#!/bin/bash

package_name=$1
environment=$2

allowed_packages=("worker" "dashboard" "api")
allowed_environments=("staging" "production")

show_usage() {
    echo "Usage: deploy.sh <package-name> <environment>"
}

show_available_packages() {
    echo "Package name must be one of: $allowed_packages"
}

show_available_envs() {
    echo "Environment must be one of: $allowed_environments"
}

find_in_array() {
  local word=$1
  shift
  for e in "$@"; do [[ "$e" == "$word" ]] && return 0; done
  return 1
}

if [ -z $1 ]; then
    echo "Package name not provided"
    show_usage
    # show_available_packages
    exit 1
fi

if [ -z $2 ]; then
    echo "Environment not provided"
    show_usage
    # show_available_envs
    exit 1
fi

cp "packages/$package_name/fly.$environment.toml" .
cp "packages/$package_name/Dockerfile" .

fly deploy -c "fly.$environment.toml"

rm "fly.$environment.toml"
rm "Dockerfile"