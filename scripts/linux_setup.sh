#!/bin/bash

# Check if high enough Go version exists, install it if not.
install_golang () {
    wget -c https://golang.org/dl/go1.17.linux-amd64.tar.gz
    tar -C /usr/local -xzf go1.17.linux-amd64.tar.gz
    echo "export PATH=\$PATH:/usr/local/go/bin" >> $HOME/.profile
    source $HOME/.profile
}

if command -v go >/dev/null 2>&1 ; then
    current_go_version=`go version | { read _ _ v _; echo ${v#go}; }`
    required_go_version="1.17"
    if [ "$(printf '%s\n' "$required_go_version" "$current_go_version" | sort -V | head -n1)" = "$required_go_version" ]; then 
        echo "Go already installed, skipping..."
    else
        echo "Correct Go version not installed, installing..."
        install_golang
    fi
else
    echo "Go not installed, installing..."
    install_golang
fi

install_protobuf() {
    wget -c https://github.com/protocolbuffers/protobuf/releases/download/v3.17.3/protoc-3.17.3-linux-x86_64.zip
    unzip -q protoc-3.17.3-linux-x86_64.zip -d $HOME/.local
    echo "export PATH=\$PATH:$HOME/.local/bin" >> $HOME/.profile
    source $HOME/.profile
}

# Check if high enough protoc exists, install it if not.
if command -v protoc >/dev/null 2>&1 ; then
    current_protoc_version=`protoc --version | { read _ v; echo $v; }`
    required_protoc_version="3.17.3"
    if [ "$(printf '%s\n' "$required_protoc_version" "$current_protoc_version" | sort -V | head -n1)" = "$required_protoc_version" ]; then 
        echo "Protobuf already installed, skipping..."
    else
        echo "Correct Protobuf version not installed, installing..."
        install_protobuf
    fi
else
    echo "Protobuf not installed, installing..."
    install_protobuf
fi

go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.26
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.1

# # Load .gitconfig
git config --local include.path "$PWD/.gitconfig"

echo "export PATH=\$PATH:$(go env GOPATH)/bin" >> $HOME/.profile
source $HOME/.profile