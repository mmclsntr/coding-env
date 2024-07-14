FROM arm64v8/debian:bullseye-slim AS build-vim

SHELL ["/bin/bash", "-c"]

RUN apt-get update \
    && apt-get install -y  \
    git \
    clang \
    libtool-bin \
    libxt-dev \
    make \
    unzip \
    curl \
    jq

# Vim install
RUN git clone https://github.com/vim/vim.git -b v9.1.0042 /root/vim
WORKDIR /root/vim/src
RUN make && make install && rm -rf vim

###################################

FROM arm64v8/debian:bullseye-slim AS build-env

SHELL ["/bin/bash", "-c"]

RUN apt-get update \
    && apt-get install -y  \
    unzip \
    git \
    libtool-bin \
    clang \
    make \
    build-essential \
    libssl-dev \
    libffi-dev \
    libncurses5-dev \
    zlib1g \
    zlib1g-dev \
    libreadline-dev \
    libbz2-dev \
    libsqlite3-dev \
    liblzma-dev \
    dirmngr \
    gpg \
    gawk \
    libsm6 \
    libxt6 \
    curl \
    jq

# install deno
RUN curl -fsSL https://deno.land/install.sh | sh

# asdf install
RUN git clone https://github.com/asdf-vm/asdf.git /root/.asdf --branch v0.14.0

# asdf install plugins
RUN mkdir -p /root/.local/share
COPY init.sh /root/init.sh
COPY setup /root/setup
COPY settings /root/settings
COPY custom /root/custom
RUN . /root/.asdf/asdf.sh && . /root/.asdf/completions/asdf.bash && /root/setup/run.sh

###################################

FROM arm64v8/debian:bullseye-slim AS workspace

SHELL ["/bin/bash", "-c"]

COPY --from=build-vim /usr/local/bin/vim /usr/local/bin/vim
COPY --from=build-vim /usr/local/share/vim /usr/local/share/vim

COPY --from=build-env /root/.deno/bin/deno /usr/local/bin/deno
COPY --from=build-env /root/.asdf /root/.asdf

RUN apt-get update \
    && apt-get install -y  \
    git \
    curl \
    libsm6 \
    libxt6 \
    jq
#&& rm -rf /var/lib/apt/lists/*

# settings
RUN mkdir -p /root/.local/share
COPY init.sh /root/init.sh
COPY setup /root/setup
COPY settings /root/settings
COPY custom /root/custom
RUN ln -s /root/settings/.vimrc /root/.vimrc
RUN rm /root/.bashrc && ln -s /root/settings/.bashrc /root/.bashrc

# Vim plug
RUN curl -fLo /root/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

WORKDIR /root/workdir

# Git config
RUN git config --global --add safe.directory *

# Vimplugs install
RUN . /root/.bashrc && vim -c PlugInstall -c q -c q
