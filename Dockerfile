FROM debian:bullseye-slim

SHELL ["/bin/bash", "-c"]

RUN apt-get update \
    && apt-get install -y libtool-bin libxt-dev clang curl git ruby build-essential libssl-dev libffi-dev libncurses5-dev zlib1g zlib1g-dev libreadline-dev libbz2-dev libsqlite3-dev make gcc exuberant-ctags ncurses-term dirmngr gpg gawk

# for test x11
RUN apt install -y x11-apps

# settings
RUN mkdir -p /root/.local/share
COPY settings /root/settings
RUN ln -s /root/settings/.vimrc /root/.vimrc
RUN rm /root/.bashrc && ln -s /root/settings/.bashrc /root/.bashrc
RUN ln -s /root/settings/.tool-versions /root/.tool-versions

# Vim install
RUN git clone https://github.com/vim/vim.git -b v9.1.0042 /root/vim
WORKDIR /root/vim/src
RUN make && make install

# asdf install
RUN git clone https://github.com/asdf-vm/asdf.git /root/.asdf --branch v0.14.0
ENV PATH="/root/.asdf/shims:/root/.asdf/bin:${PATH}"

RUN asdf plugin add nodejs && \
    asdf plugin add python && \
    asdf plugin add golang && \
    asdf plugin add awscli && \
    asdf plugin add aws-sam-cli

RUN asdf install

WORKDIR /root/workdir
