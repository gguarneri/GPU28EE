#include "cuda_utils.cuh"

#define N 512

void host_add(int *a, int *b, int *c) {
	for(int idx=0;idx<N;idx++)
		c[idx] = a[idx] + b[idx];
}

__global__ void device_add(int *a, int *b, int *c) {
    c[blockIdx.x] = a[blockIdx.x] + b[blockIdx.x];
	// c[threadIdx.x] = a[threadIdx.x] + b[threadIdx.x];
	// int index = threadIdx.x + blockIdx.x * blockDim.x;
    // c[index] = a[index] + b[index];
}


//basically just fills the array with index.
void fill_array(int *data) {
	for(int idx=0;idx<N;idx++)
		data[idx] = idx + 1;
}

void print_output(int *a, int *b, int*c) {
	for(int idx=0;idx<N;idx++)
		printf("\n %d + %d  = %d",  a[idx] , b[idx], c[idx]);
    printf("\n");
}

int main(void) {
	int *a, *b, *c;
    int *d_a, *d_b, *d_c; // device copies of a, b, c
	// int threads_per_block=0, no_of_blocks=0;

	int size = N * sizeof(int);

	// Alloc space for host copies of a, b, c and setup input values
	a = (int *)malloc(size); fill_array(a);
	b = (int *)malloc(size); fill_array(b);
	c = (int *)malloc(size);

    // Alloc space for device copies of a, b, c
    cudaMalloc((void **)&d_a, size);
    cudaMalloc((void **)&d_b, size);
    cudaMalloc((void **)&d_c, size);

    // Copy inputs to device
    cudaMemcpy(d_a, a, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, size, cudaMemcpyHostToDevice);

	// <<< Grid, Block >>>
	// Block: agrupamento de threads que cooperam entre si. 
	//        Trabalho em equipe - Todas as threads dentro do mesmo bloco podem se comunicar
	//        facilmente usando uma memória ultrarrápida chamada Shared Memory (Memória Compartilhada).
	// Grid : conjunto de todos os blocos criados para executar um determinado Kernel.
	//        Ele representa a carga total de trabalho (workgroup) daquela chamada.
	device_add<<<N, 1>>>(d_a,d_b,d_c);
	// device_add<<<1, N>>>(d_a,d_b,d_c);

	// threads_per_block = 8;    // <-- Scenario 1
    // threads_per_block = 4;    // <-- Scenario 2
    // threads_per_block = 16;   //
	// no_of_blocks = N/threads_per_block;
	// device_add<<<no_of_blocks, threads_per_block>>>(d_a,d_b,d_c);

    // Copy result back to host
    cudaMemcpy(c, d_c, size, cudaMemcpyDeviceToHost);

	print_output(a,b,c);

	free(a); free(b); free(c);
    cudaFree(d_a); cudaFree(d_b); cudaFree(d_c);

	return 0;
}