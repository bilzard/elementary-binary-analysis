FROM ubuntu:22.04

WORKDIR /binary-analysis
RUN apt update && apt upgrade -y
RUN apt install -y \
  vim \
  gcc \
  hexedit \
  less \
  ncal \
  g++ \
  pip \
  git \
  curl \
  file \
  locales \
  wget \
  lsb-core \
  lsb-release \
  lldb \
  python3-lldb-14 \
  ruby \
  tmux \
  nasm \
  gcc-multilib \
  gdb \
  checksec

# pwn
RUN pip install pwn

# set locale UTF-8
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# lldb
RUN ln -s /usr/lib/llvm-14/lib/python3.10/dist-packages/lldb/* /usr/lib/python3/dist-packages/lldb/

# voltron
RUN git clone https://github.com/snare/voltron && \
  cd voltron && ./install.sh -s -b lldb

# tmuxinator
RUN gem install tmuxinator
RUN echo 'export EDITOR=vim' >> ~/.bashrc
RUN echo 'export SHELL=/usr/bin/bash' >> ~/.bashrc
RUN wget https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.bash -O /etc/bash_completion.d/tmuxinator.bash
COPY ./artifact/voltron.yml /root/.config/tmuxinator/voltron.yml
RUN echo 'alias mux=tmuxinator' >> ~/.bashrc

# peda
RUN git clone https://github.com/longld/peda.git ~/peda && \
  echo "source ~/peda/peda.py" >> ~/.gdbinit

# tmux
COPY ./artifact/tmux.conf ~/.tmux.conf

# vimrc
COPY ./artifact/vimrc /root/.vimrc
WORKDIR /binary-analysis/working
