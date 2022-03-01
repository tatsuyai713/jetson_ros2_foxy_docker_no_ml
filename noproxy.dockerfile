FROM ubuntu:20.04

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

RUN echo "deb https://repo.download.nvidia.com/jetson/common r32.6 main" > /etc/apt/sources.list.d/nvidia-l4t-apt-source.list && \
        echo "deb https://repo.download.nvidia.com/jetson/t194 r32.6 main" >> /etc/apt/sources.list.d/nvidia-l4t-apt-source.list

RUN apt update


RUN wget http://ports.ubuntu.com/pool/main/libf/libffi/libffi6_3.2.1-8_arm64.deb
RUN apt install -y ./libffi6_3.2.1-8_arm64.deb

RUN wget \
        http://ports.ubuntu.com/pool/main/libv/libvpx/libvpx5_1.7.0-3ubuntu0.18.04.1_arm64.deb \
        http://ports.ubuntu.com/pool/universe/f/ffmpeg/libavcodec57_3.4.8-0ubuntu0.2_arm64.deb \
        http://ports.ubuntu.com/pool/universe/f/ffmpeg/libavformat57_3.4.8-0ubuntu0.2_arm64.deb \
        http://ports.ubuntu.com/pool/universe/f/ffmpeg/libavutil55_3.4.8-0ubuntu0.2_arm64.deb \
        http://ports.ubuntu.com/pool/universe/f/ffmpeg/libswresample2_3.4.8-0ubuntu0.2_arm64.deb \
        http://ports.ubuntu.com/pool/universe/f/ffmpeg/libswscale4_3.4.8-0ubuntu0.2_arm64.deb \
        http://ports.ubuntu.com/pool/universe/x/x264/libx264-152_0.152.2854+gite9a5903-2_arm64.deb \
        http://ports.ubuntu.com/pool/universe/x/x265/libx265-146_2.6-3_arm64.deb

RUN apt install -y \
        ./libvpx5_*_arm64.deb \
        ./libavcodec57_*_arm64.deb \
        ./libavformat57_*_arm64.deb \
        ./libavutil55_*_arm64.deb \
        ./libswresample2_*_arm64.deb \
        ./libswscale4_*_arm64.deb \
        ./libx264-152_*_arm64.deb \
        ./libx265-146_*_arm64.deb


RUN wget http://ports.ubuntu.com/pool/main/p/python3.6/python3.6_3.6.9-1~18.04ubuntu1.6_arm64.deb \
        http://ports.ubuntu.com/pool/main/p/python3.6/python3.6-minimal_3.6.9-1~18.04ubuntu1.6_arm64.deb \
        http://ports.ubuntu.com/pool/main/p/python3.6/libpython3.6-stdlib_3.6.9-1~18.04ubuntu1.6_arm64.deb \
        http://ports.ubuntu.com/pool/main/p/python3.6/libpython3.6-minimal_3.6.9-1~18.04ubuntu1.6_arm64.deb \
        http://ports.ubuntu.com/pool/main/r/readline/libreadline7_7.0-3_arm64.deb \
        http://ports.ubuntu.com/pool/main/p/python3-defaults/python3_3.6.7-1~18.04_arm64.deb \
        http://ports.ubuntu.com/pool/main/p/python3-defaults/python3-minimal_3.6.7-1~18.04_arm64.deb \
        http://ports.ubuntu.com/pool/main/p/python3-defaults/libpython3-stdlib_3.6.7-1~18.04_arm64.deb \
        http://ports.ubuntu.com/pool/main/p/python3-stdlib-extensions/python3-distutils_3.6.9-1~18.04_all.deb \
        http://ports.ubuntu.com/pool/main/p/python3-stdlib-extensions/python3-lib2to3_3.6.9-1~18.04_all.deb

RUN apt install -y --allow-downgrades \
        ./python3_*_arm64.deb \
        ./python3-minimal_*_arm64.deb \
        ./libpython3-stdlib_*_arm64.deb \
        ./python3.6_*_arm64.deb \
        ./python3.6-minimal_*_arm64.deb \
        ./libpython3.6-stdlib_*_arm64.deb \
        ./libpython3.6-minimal_*_arm64.deb \
        ./libreadline7_*_arm64.deb \
        ./python3-distutils_*_all.deb \
        ./python3-lib2to3_*_all.deb

RUN apt install -y \
        libgstreamer1.0-dev \
        libgstreamer-plugins-base1.0-dev \
        libglib2.0-dev \
        libglib2.0-dev-bin \
        jetson-gpio-common \
        nvidia-cuda \
        cuda-minimal-build-10-2 \
        cuda-gdb-src-10-2 \
        nvidia-cudnn8 \
        nvidia-tensorrt \
        python3-libnvinfer \
        python3-libnvinfer-dev \
        python-jetson-gpio \
        python3-jetson-gpio \
        libdrm-tegra0 \
        nvidia-visionworks \
        libvisionworks-samples \
        libvisionworks-sfm-dev \
        libvisionworks-tracking-dev \
        deepstream-6.0 \
        libglew-dev \
        nsight-systems-cli-2021.2.3



RUN apt-get update && \
    apt-get install -y curl gnupg2 lsb-release && \
    curl http://repo.ros2.org/repos.key | apt-key add - && \
    sh -c 'echo "deb [arch=amd64,arm64] http://packages.ros.org/ros2/ubuntu \
    `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list' && \
    apt-get update

RUN apt update && apt install -y ros-foxy-desktop  python3-colcon-common-extensions



RUN apt update
RUN apt download python3-libnvinfer=8.0.1-1+cuda10.2
ENV DEBFILE="python3-libnvinfer_8.0.1-1+cuda10.2_arm64.deb"
RUN mkdir temp
RUN chmod 777 temp
ENV TMPDIR=./temp
ENV OUTPUT=python3-libnvinfer_8.0.1-1+cuda10.2_arm64.modified.deb
RUN dpkg-deb -x "$DEBFILE" "$TMPDIR"
RUN dpkg-deb --control "$DEBFILE" "$TMPDIR"/DEBIAN
ENV CONTROL=./temp/DEBIAN/control
RUN sed -i 's/^Depends: python3 (>= 3.6), python3 (<< 3.7)/Depends: python3.6/g' $CONTROL
RUN dpkg -b "$TMPDIR" "$OUTPUT"
RUN rm -r "$TMPDIR"
RUN dpkg -i python3-libnvinfer_8.0.1-1+cuda10.2_arm64.modified.deb
RUN apt install python3-libnvinfer-dev=8.0.1-1+cuda10.2 nvidia-tensorrt


RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update
RUN apt-get install -y python3.6 python3.8 libpython3.6-stdlib libpython3.8-stdlib libpython3.6-minimal libpython3.8-minimal 
RUN update-alternatives --install /usr/bin/python python /usr/bin/python2.7 1
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.8 2
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.6 3


RUN apt upgrade -y && apt autoremove -y && apt clean && \
        rm -rf /var/lib/apt/lists/*

RUN gpasswd -a $USERNAME video

# set locale
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

