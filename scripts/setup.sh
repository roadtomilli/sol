# Check if Homebrew exists, install it if not.
which -s brew
if [[ $? != 0 ]] ; then
    echo "Homebrew not installed, installing..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo "Homebrew already installed, checking for update..."
    brew update
fi

# Check if Go exists, install it if not.
GOVERSION=$(go version)
if [[ "$GOVERSION" != *"1.17"* ]] ; then
    echo "Correct Golang version not installed, installing..."
    brew install go@1.17
else
    echo "Golang already installed, skipping..."
fi

# Load .gitconfig
git config --local include.path "$PWD/.gitconfig"