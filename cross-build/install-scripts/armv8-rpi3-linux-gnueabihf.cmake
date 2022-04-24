set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR $ENV{HOST_ARCH})

set(CMAKE_C_COMPILER $ENV{HOST_TRIPLE}-gcc)
set(CMAKE_CXX_COMPILER $ENV{HOST_TRIPLE}-g++)
set(CMAKE_Fortran_COMPILER $ENV{HOST_TRIPLE}-gfortran)
set(CMAKE_LIBRARY_ARCHITECTURE $ENV{HOST_TRIPLE_LIB_DIR})

set(CMAKE_SYSROOT $ENV{RPI_SYSROOT})
set(CMAKE_STAGING_PREFIX $ENV{RPI_STAGING}/usr/local)
set(CMAKE_FIND_ROOT_PATH ${CMAKE_SYSROOT})

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)