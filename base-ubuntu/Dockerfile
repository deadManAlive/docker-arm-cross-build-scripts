FROM ubuntu:focal as rpi-cpp-toolchain-base-ubuntu

# Install some tools and compilers + clean up
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y sudo git wget \
                       gcc g++ cmake make autoconf automake \
                       gperf diffutils bzip2 libbz2-dev xz-utils \
                       flex gawk help2man libncurses-dev patch bison \
                       python-dev gnupg2 texinfo unzip libtool-bin \
                       autogen libtool m4 gettext pkg-config && \
    apt-get clean autoclean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

# Add a user called `develop`, and add him to the sudo group
RUN useradd -m develop && \
    echo "develop:develop" | chpasswd && \
    adduser develop sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER develop
WORKDIR /home/develop