FROM debian:bullseye-slim

SHELL ["/bin/bash", "-c"]

RUN apt-get update \
    && apt-get install -y vim curl git build-essential libssl-dev libffi-dev libncurses5-dev zlib1g zlib1g-dev libreadline-dev libbz2-dev libsqlite3-dev make gcc

# Anyenv
RUN git clone https://github.com/anyenv/anyenv /root/.anyenv \
 && export PATH="/root/.anyenv/bin:$PATH" \
 && echo '' >> /root/.bashrc \
 && echo '# anyenv' >> /root/.bashrc \
 && echo 'export PATH="/root/.anyenv/bin:$PATH"' >> /root/.bashrc \
 && echo 'eval "$(anyenv init -)"' >> /root/.bashrc

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


COPY .vimrc /root/.vimrc
WORKDIR /root/app
