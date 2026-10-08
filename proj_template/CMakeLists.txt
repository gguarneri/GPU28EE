cmake_minimum_required(VERSION 3.24)
project(cuda_app LANGUAGES CXX CUDA)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CUDA_STANDARD 17)
set(CMAKE_CUDA_STANDARD_REQUIRED ON)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
endif()

# Arquitetura da GPU (ex.: 75, 86, 89). "native" requer CMake >= 3.24
if(NOT DEFINED CMAKE_CUDA_ARCHITECTURES)
  set(CMAKE_CUDA_ARCHITECTURES native)
endif()

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)

add_executable(cuda_app)

target_sources(cuda_app PRIVATE src/main.cu)

target_include_directories(cuda_app PRIVATE ${PROJECT_SOURCE_DIR}/include)

set_target_properties(cuda_app PROPERTIES CUDA_SEPARABLE_COMPILATION ON)
