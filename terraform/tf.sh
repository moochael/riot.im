#!/bin/bash

ANSIBLE_BIN=$(command -v ansible)
TERRAFORM_BIN=$(command -v terraform)
TFPLAN_FILE="tfplan"

. ./secrets.sh

# echo "environment variables:"
# echo "TF_VAR_do_token:                $TF_VAR_do_token"
# echo "TF_VAR_do_spaces_access_token:  $TF_VAR_do_spaces_access_token"
# echo "TF_VAR_do_spaces_secret_key:    $TF_VAR_do_spaces_secret_key"
# echo "TF_VAR_do_space_bucket_name:    $TF_VAR_do_space_bucket_name"

### Functions
terraform_init() {
  $TERRAFORM_BIN init \
    -backend-config="access_key=$TF_VAR_do_spaces_access_token" \
    -backend-config="secret_key=$TF_VAR_do_spaces_secret_key" \
    -backend-config="bucket=$TF_VAR_do_space_bucket_name"
}

terraform_plan() {
  $TERRAFORM_BIN plan -out=$TFPLAN_FILE
}

terraform_apply() {
  $TERRAFORM_BIN apply $TFPLAN_FILE
}

terraform_destroy() {
  $TERRAFORM_BIN destroy -auto-approve
}

usage() {
  echo "Usage: $0 <build|destroy>"
  echo "Run \`$0 build\` to build the infrasructure."
  echo "Run \`$0 destroy\` to destroy the infrasructure."
}

if [ -z "$1" ]; then
  usage
  exit 1

elif [[ "$1" == "build" ]]; then
  terraform_init
  terraform_plan
  terraform_apply
  rm $TFPLAN_FILE
  exit 0

elif [[ "$1" == "destroy" ]]; then
  terraform_init
  terraform_destroy
  exit 0

else
  echo "I don't know what to do with \`$1\`."
  exit 1
fi
