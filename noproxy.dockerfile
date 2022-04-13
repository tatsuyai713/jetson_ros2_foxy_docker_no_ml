FROM arm64v8/ubuntu:20.04

ARG UID=9001
ARG GID=9001
ARG UNAME=ubuntu
ARG HOSTNAME=docker

ARG NEW_HOSTNAME=Docker-${HOSTNAME}

ARG USERNAME=$UNAME
ARG HOME=/home/$USERNAME

RUN useradd -u $UID -m $USERNAME && \
        echo "$USERNAME:$USERNAME" | chpasswd && \
        usermod --shell /bin/bash $USERNAME && \
        usermod -aG sudo $USERNAME && \
        mkdir /etc/sudoers.d && \
        echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USERNAME && \
        chmod 0440 /etc/sudoers.d/$USERNAME && \
        usermod  --uid $UID $USERNAME && \
        groupmod --gid $GID $USERNAME && \
        chown -R $USERNAME:$USERNAME $HOME && \
        chmod 666 /dev/null && \
        chmod 666 /dev/urandom

# install package
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        curl \
        sudo \
        less \
        apt-utils \
        tzdata \
        git \
        tmux \
        bash-completion \
        command-not-found \
        libglib2.0-0 \
        vim \
        emacs \
        ssh \
        rsync \
        sed \
        ca-certificates \
        wget \
        git \
        gpg \
        gpg-agent \
        gpgconf \
        gpgv \
        lsb-release \
        net-tools \
        gnupg \
        locales \
        avahi-daemon



RUN apt-key adv --fetch-key http://repo.download.nvidia.com/jetson/jetson-ota-public.asc

RUN echo "deb https://repo.download.nvidia.com/jetson/common r34.1 main" > /etc/apt/sources.list.d/nvidia-l4t-apt-source.list && \
        echo "deb https://repo.download.nvidia.com/jetson/t194 r34.1 main" >> /etc/apt/sources.list.d/nvidia-l4t-apt-source.list

RUN apt update && apt install -y curl gnupg2 lsb-release
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key  -o /usr/share/keyrings/ros-archive-keyring.gpg
RUN curl http://repo.ros2.org/repos.key | sudo apt-key add -
RUN sh -c 'echo "deb [arch=amd64,arm64] http://packages.ros.org/ros2/ubuntu \
    `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list'

RUN apt update
RUN apt install -y nvidia-cuda nvidia-cudnn8 nvidia-cuda-doc nvidia-tensorrt nvidia-vpi nvidia-opencv nvidia-vpi
RUN apt install -y ros-foxy-desktop  python3-colcon-common-extensions  python3-colcon-common-extensions

RUN apt upgrade -y && apt autoremove -y && apt clean && \
        rm -rf /var/lib/apt/lists/*

RUN gpasswd -a $USERNAME video

# set locale
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN rm /etc/apt/apt.conf.d/docker-clean
