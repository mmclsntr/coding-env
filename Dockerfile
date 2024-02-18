FROM arm64v8/debian:bullseye-slim

SHELL ["/bin/bash", "-c"]

RUN apt-get update \
    && apt-get install -y libtool-bin libxt-dev clang curl git ruby build-essential libssl-dev libffi-dev libncurses5-dev zlib1g zlib1g-dev libreadline-dev libbz2-dev libsqlite3-dev exuberant-ctags ncurses-term dirmngr gpg gawk

# install jq
RUN apt-get install -y jq

# install deno
# RUN curl -fsSL https://deno.land/install.sh | sh
RUN curl -s https://gist.githubusercontent.com/LukeChannings/09d53f5c364391042186518c8598b85e/raw/ac8cd8c675b985edd4b3e16df63ffef14d1f0e24/deno_install.sh | sh

# for test x11
RUN apt install -y x11-apps

# settings
RUN mkdir -p /root/.local/share
COPY init.sh /root/init.sh
COPY setup /root/setup
COPY settings /root/settings
RUN ln -s /root/settings/.vimrc /root/.vimrc
RUN rm /root/.bashrc && ln -s /root/settings/.bashrc /root/.bashrc

# Vim install
RUN git clone https://github.com/vim/vim.git -b v9.1.0042 /root/vim
WORKDIR /root/vim/src
RUN make 
RUN make install
# Vim plug
RUN curl -fLo /root/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# asdf install
RUN git clone https://github.com/asdf-vm/asdf.git /root/.asdf --branch v0.14.0
ENV PATH="/root/.asdf/shims:/root/.asdf/bin:${PATH}"

WORKDIR /root/workdir

# Git config
RUN git config --global --add safe.directory *
