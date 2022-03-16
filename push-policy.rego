package spacelift

# When attached to a stack, this policy ignores all code change pushes.
# This is helpful when runs are triggered elsewhere.
# For example, via a GitHub Action so that runs can be signed.
ignore { true }
