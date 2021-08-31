#!/bin/bash

# Check if Homebrew exists, install it if not.
which -s brew
if [[ $? != 0 ]] ; then
    echo "Homebrew not installed, installing..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo "Homebrew already installed, checking for update..."
    brew update
fi

# Check if high enough Go version exists, install it if not.
which_go=$(which -s go)]
if [[ $which_go != 0 ]] ; then
    current_go_version=`go version | { read _ _ v _; echo ${v#go}; }`
    required_go_version="1.17"
    if [ "$(printf '%s\n' "$required_go_version" "$current_go_version" | sort -V | head -n1)" = "$required_go_version" ]; then 
        echo "Go already installed, skipping..."
    else
        brew install go@1.17
        echo "Correct Go version not installed, installing..."
    fi
else
    echo "Go not installed, installing..."
    brew install go@1.17
fi

# Check if high enough protoc exists, install it if not.
which_protoc=$(which -s protoc)
if [[ $which_protoc != 0 ]] ; then
    current_protoc_version=`protoc --version | { read _ v; echo $v; }`
    required_protoc_version="3.17.3"
    if [ "$(printf '%s\n' "$required_protoc_version" "$current_protoc_version" | sort -V | head -n1)" = "$required_protoc_version" ]; then 
        echo "Protobuf already installed, skipping..."
    else
        brew install protobuf@3.17.3
        echo "Correct Protobuf version not installed, installing..."
    fi
else
    echo "Protobuf not installed, installing..."
    brew install protobuf@3.17.3
fi

# Load .gitconfig
git config --local include.path "$PWD/.gitconfig"