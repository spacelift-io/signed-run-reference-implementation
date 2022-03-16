package spacelift

deny["Invalid token"] {
  token := input.run.user_provided_metadata[0]
  contraints := {
    # Replace ${SECRET} with the secret you added to GitHub secrets as SPACELIFT_RUN_SIGNATURE_SECRET.
    #
    # Hardcoding a secret is not ideal but since you manage the policy and the server it is stored on,
    # there should not be any security issue with that.
    "secret": "${SECRET}"
  }

  [valid, _, payload] := io.jwt.decode_verify(token, contraints)
  not valid
}

deny["Stack mismatch"] {
  token := input.run.user_provided_metadata[0]

  [_, payload, _] := io.jwt.decode(token)
  payload.spacelift_stack != input.static_run_environment.stack_slug
}

deny["Commit mismatch"] {
  token := input.run.user_provided_metadata[0]

  [_, payload, _] := io.jwt.decode(token)
  payload.sub != input.run.commit.hash
}

sample { true }
