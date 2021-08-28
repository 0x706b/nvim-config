filepath=$1

prettier --stdin-filepath $filepath | eslint_d --stdin --stdin-filename $filepath --fix-to-stdout
