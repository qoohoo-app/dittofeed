#!/bin/bash

package_name=$1
environment=$2

allowed_packages=("worker" "dashboard" "api" "temporal" "clickhouse")
allowed_environments=("staging" "production")

show_usage() {
    echo "Usage: deploy.sh <package-name> <environment>"
}

show_available_packages() {
    echo "Package name must be one of: ${allowed_packages[@]}"
}

show_available_envs() {
    echo "Environment must be one of: ${allowed_environments[@]}"
}

check_value_in_array() {
    local value=$1
    
    shift # Remove $1 from $@

    array=("$@")  # Get $2 $3 .... as array

    for i in "${array[@]}"
    do
        if [[ $i == $value ]]; then
            return 0
        fi
    done

    return 1
}

if [[ -z $package_name ]]; then
    echo "Package name not provided"
    show_usage
    exit 1
fi

if ! check_value_in_array "$package_name" "${allowed_packages[@]}"; then
    echo "Invalid package name: $package_name"
    show_available_packages
    exit 1
fi

if [[ -z $environment ]]; then
    echo "Environment not provided"
    show_usage
    exit 1
fi

if ! check_value_in_array "$environment" "${allowed_environments[@]}"; then
    echo "Invalid Environment: $environment"
    show_available_envs
    exit 1
fi

cp "packages/$package_name/fly.$environment.toml" "fly.$environment.$package_name.toml"
cp "packages/$package_name/Dockerfile" "$environment.$package_name.Dockerfile"

fly deploy -c "fly.$environment.$package_name.toml" --depot=false --dockerfile "$environment.$package_name.Dockerfile"

rm "fly.$environment.$package_name.toml"
rm "$environment.$package_name.Dockerfile"