FROM arm64v8/ubuntu

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get -y install \
    libtool \
    cmake \
    automake \
    autoconf \
    make \
    ninja-build \
    curl \
    unzip \
    zip \
    wget \
    virtualenv \
    build-essential \
    openjdk-8-jdk \
    python2 \
    git

RUN wget -O bazel https://github.com/bazelbuild/bazel/releases/download/3.4.0/bazel-3.4.0-linux-arm64 && chmod +x bazel
RUN mv bazel usr/local/bin/bazel

RUN wget https://dl.google.com/go/go1.14.2.linux-arm64.tar.gz
RUN tar -C /usr/local -xzf go1.14.2.linux-arm64.tar.gz
ENV PATH=$PATH:/usr/local/go/bin

RUN git clone https://github.com/envoyproxy/envoy.git
WORKDIR /envoy
RUN bazel build -c opt //source/exe:envoy-static