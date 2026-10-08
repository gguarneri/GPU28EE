# Template de projeto CUDA com CMake

```
proj_template/
├── CMakeLists.txt      # configuração raiz
├── include/            # headers (.cuh/.h)
├── src/                # código-fonte (.cu/.cpp)
│   ├── main.cu
└── build/              # gerado pelo CMake
```

## Compilação

```bash
cmake -S . -B build -DCMAKE_CUDA_ARCHITECTURES=86
cmake --build build -j
./build/bin/app
ctest --test-dir build
```
