FROM mcr.microsoft.com/devcontainers/base:noble

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y \
  autoconf \
  build-essential \
  libdb-dev \
  libffi-dev \
  libgdbm-dev \
  libgdbm6 \
  libgmp-dev \
  libncurses5-dev \
  libreadline6-dev \
  libsqlite3-dev \
  libssl-dev \
  libyaml-dev \
  patch \
  rustc \
  sqlite3 \
  shellcheck \
  uuid-dev \
  zlib1g-dev

USER vscode

ARG RUBY_VERSION=truffleruby+graalvm-23.1.2
ENV PATH $HOME/.rbenv/shims:$HOME/.rbenv/bin:$HOME/.rbenv/plugins/ruby-build/bin:$PATH

RUN curl -fsSL https://github.com/rbenv/rbenv-installer/raw/main/bin/rbenv-installer | bash \
  && ~/.rbenv/bin/rbenv install "${RUBY_VERSION}" \
  && ~/.rbenv/bin/rbenv global "${RUBY_VERSION}"

RUN echo 'unset GEM_PATH' >> ~/.zshrc
RUN echo 'unset GEM_HOME' >> ~/.zshrc
RUN echo 'eval "$(rbenv init - --no-rehash zsh)"' >> ~/.zshrc
