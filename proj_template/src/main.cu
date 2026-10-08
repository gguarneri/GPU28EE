#include "cuda_utils.cuh"

__global__ void hello() {
    printf("Hello from GPU");
}

int main() {
    int count = 0;

    CUDA_CHECK(cudaGetDeviceCount(&count));
    printf("Device Count: %d\n", count);
    if (count == 0) return 0;

    hello<<<1, 1>>>();

    // Sincronização para flushing do buffer no Host
    CUDA_CHECK(cudaDeviceSynchronize());
}
