# troy := seal-cuda

The homomorphic encryption library implemented on GPU. Troy includes BFV, BGV, and CKKS schemes. Its implementation referred to the [Microsoft SEAL library](https://github.com/Microsoft/SEAL).
For reference, this library inherently includes a CPU version of the schemes, but you can just use the GPU part by using namespace `troyn`.

## Brief usage
The interfaces (classes, methods, etc.) are basicly the same as in SEAL, but you need to initialize the CUDA kernels (`troyn::KernelProvider::initialize()`) before using any of the GPU related classes. You can just call this at the beginning of your programs.

See `test/timetest.cu` for example.

## Code structures
* `src` includes the implementation of the library. Just include `troy_cuda.cuh` and you are ready to go.
* `test` includes the tests.
* `extern` includes third-party libraries: googletest and pybind11.
* `binder` includes the pybind11 code to encapsulate the C/C++/CUDA interfaces for python.
* `app` includes a high-level implementation for computing matrix multiplication and 2d-convolution in HE.

## How to run

0. Make and install SEAL 4.0
    This requires `sudo` privilige to install the binary library file.
    ```
    bash install_seal.sh
    ```
1. Build the basic library
    ```
    mkdir build
    cd build
    cmake ..
    make
    cd ..
    ```
2. Run tests
    ```
    cd build
    ctest
    ./test/timetest
    cd ..
    ```
3. Make the module for python
    ```
    bash makepackage.sh
    ```
    
## Contribute
Feel free to fork / pull request.
Please cite this repository if you use it in your work.