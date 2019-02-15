# bpftrace builder

Helper containers to build [bpftrace](https://github.com/iovisor/bpftrace) on
multiple LLVM versions.

Available LLVM versions: 5, 6 and 7.

## Usage

```bash
git clone https://github.com/mmarchini/bpftrace-builder
cd bpftrace-builder
# Build containers
make
export BPFTRACE_BUILDER_PATH=$(pwd)
cd /path/to/bpftrace-repository
ln -s $BPFTRACE_BUILDER_PATH/bpftrace-builder
# Runs the container
./bpftrace-builder
```

`WORKDIR` for each container is the build directory. Run `cmake ..` and 
`make -j10` to build bpftrace.

`./bpftrace-builder` accepts one positional argument with the LLVM version:

```bash
# LLVM 5
./bpftrace-builder 5
# LLVM 6
./bpftrace-builder 6
# LLVM 7
./bpftrace-builder 7
```
