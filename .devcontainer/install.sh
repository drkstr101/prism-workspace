#!/usr/bin/env bash

# Devcontainer setup script

set -eu
set -o pipefail

readonly BIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PRISM_WORKSPACE="$(cd "${BIN_DIR}/.." && pwd)"
readonly RUBY_VERSION="truffleruby+graalvm-23.1.2"

# System cleanup
# sudo /usr/local/rvm/bin/rvm implode

# Add extras
sudo unminimize

# Install dependencies
sudo apt-get update
xargs sudo apt-get -y install < "${PRISM_WORKSPACE}/.devcontainer/packages.txt"

# Install rbenv
# curl -fsSL https://github.com/rbenv/rbenv-installer/raw/main/bin/rbenv-installer | bash

# More recent versions of truffleruby are installable with rbenv but not rvm
rbenv install "${RUBY_VERSION}"
rbenv global "${RUBY_VERSION}"

# Add rbenv to PATH
echo 'unset GEM_PATH' >> ~/.zshrc
echo 'unset GEM_HOME' >> ~/.zshrc
echo 'eval "$(rbenv init - --no-rehash zsh)"' >> ~/.zshrc
