FROM debian:bullseye-slim

SHELL ["/bin/bash", "-c"]

RUN apt-get update \
    && apt-get install -y vim curl git ruby build-essential libssl-dev libffi-dev libncurses5-dev zlib1g zlib1g-dev libreadline-dev libbz2-dev libsqlite3-dev make gcc  exuberant-ctags ncurses-term

# settings
RUN mkdir -p /root/.local/share
COPY settings /root/settings
RUN ln -s /root/settings/.vimrc /root/.vimrc
RUN rm /root/.bashrc && ln -s /root/settings/.bashrc /root/.bashrc

# Anyenv
RUN git clone https://github.com/anyenv/anyenv /root/.anyenv \
 && export PATH="/root/.anyenv/bin:$PATH"

ENV PATH="/root/.anyenv/bin:$PATH"

RUN anyenv install --force-init

# Nodenv
RUN anyenv install nodenv
RUN eval "$(anyenv init -)" \
 && nodenv install 20.8.0 \
 && nodenv global 20.8.0

# Pyenv
RUN anyenv install pyenv
RUN eval "$(anyenv init -)" \
 && pyenv install 3.10.1 \
 && pyenv rehash \
 && pyenv global 3.10.1

WORKDIR /root/app
