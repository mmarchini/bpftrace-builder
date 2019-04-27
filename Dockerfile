FROM ubuntu:bionic

ARG llvm_version
ENV llvmVersion=$llvm_version

RUN apt-get update && apt-get install -y curl gnupg &&\
    llvmRepository="\n\
deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic main\n\
deb-src http://apt.llvm.org/bionic/ llvm-toolchain-bionic main\n\
deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-$llvmVersion main\n\
deb-src http://apt.llvm.org/bionic/ llvm-toolchain-bionic-$llvmVersion main\n" && \
    echo $llvmRepository >> /etc/apt/sources.list && \
    curl -L https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4052245BD4284CDD && \
    echo "deb https://repo.iovisor.org/apt/bionic bionic main" | tee /etc/apt/sources.list.d/iovisor.list

RUN apt-get update && apt-get install -y \
      bison \
      cmake \
      flex \
      g++ \
      git \
      libelf-dev \
      zlib1g-dev \
      libbcc \
      clang-${llvmVersion} \
      libclang-${llvmVersion}-dev \
      libclang-common-${llvmVersion}-dev \
      libclang1-${llvmVersion} \
      llvm-${llvmVersion} \
      llvm-${llvmVersion}-dev \
      llvm-${llvmVersion}-runtime \
      libllvm${llvmVersion}

WORKDIR /bpftrace/build-llvm$llvm_version
