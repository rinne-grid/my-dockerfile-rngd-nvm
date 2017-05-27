FROM centos
MAINTAINER grid rinne <Rinne.Grids@gmail.com>
# docker build -t rngd/nvm-node6.x .
# docker run -i -t rngd/nvm-node6.x /bin/bash
#------------------------------------------------------------------------------
# 作成するLinuxユーザを指定。デフォルトはdev
#------------------------------------------------------------------------------
ENV DEV_USER dev
ENV THIS_NODE_VERSION v6.10.3
RUN adduser $DEV_USER
ENV HOME /home/$DEV_USER
WORKDIR /home/$DEV_USER

#------------------------------------------------------------------------------
# nvmの設定
#------------------------------------------------------------------------------
USER $DEV_USER
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
ENV NVM_DIR "$HOME/.nvm"
RUN chmod 755 "$NVM_DIR/nvm.sh" 
RUN [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" && \ 
    nvm install $THIS_NODE_VERSION && nvm use $THIS_NODE_VERSION 
ENV NPM_DIR "$NVM_DIR/versions/node/$THIS_NODE_VERSION/bin"
#------------------------------------------------------------------------------
# パッケージのインストール
#------------------------------------------------------------------------------
USER root
ADD ./mongodb.repo /etc/yum.repos.d/mongodb.repo
RUN yum -y update && yum install -y \
    mongodb-org \
    make \
    sudo \
    git  \
    vim  \
    gcc gcc-c++ kernel-devel kernel-headers dkms
RUN echo "$DEV_USER    ALL=NOPASSWD:    ALL" >> /etc/sudoers
#------------------------------------------------------------------------------
# crowiの取得
#------------------------------------------------------------------------------
USER $DEV_USER
RUN git clone -b v1.6.1 https://github.com/crowi/crowi
WORKDIR $HOME/crowi
#RUN "$NPM_DIR/npm install" && "$NPM_DIR/npm cache clean"
EXPOSE 80
EXPOSE 22