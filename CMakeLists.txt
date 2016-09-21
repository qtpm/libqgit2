cmake_minimum_required(VERSION 3.1.0)

# project global setting

project(libqgit2)

set(LIBQGIT2_MAJOR_VERSION 0)
set(LIBQGIT2_MINOR_VERSION 22)
set(LIBQGIT2_PATCH_VERSION 1)
set(LIBQGIT2_VERSION 0.22.1)

if(DEFINED QTPM_IS_ROOT_PROJECT)
    set(READ_SUBDIRECTORIES FALSE)
else()
    set(READ_SUBDIRECTORIES TRUE)
    set(QTPM_IS_ROOT_PROJECT FALSE)
endif()

if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/../../vendor)
    set(VENDOR_PATH ${CMAKE_CURRENT_SOURCE_DIR}/..)
else()
    set(VENDOR_PATH ${CMAKE_CURRENT_SOURCE_DIR}/vendor)
endif()

# compiler setting

set(CMAKE_POSITION_INDEPENDENT_CODE TRUE)
set(CMAKE_CXX_STANDARD 11)
if(MSVC)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /W4")
else()
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall")
endif()
if(DEFINED EMSCRIPTEN)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s BINARYEN_METHOD='native-wasm,asmjs' -s BINARYEN=1")
endif()

if(APPLE)
    set(CMAKE_MACOSX_RPATH ON)
    set(CMAKE_SKIP_BUILD_RPATH FALSE)
    set(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE)
    set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/lib")
    set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)
    list(FIND CMAKE_PLATFORM_IMPLICIT_LINK_DIRECTORIES "${CMAKE_INSTALL_PREFIX}/lib" isSystemDir)
    if("${isSystemDir}" STREQUAL "-1")
        set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/lib")
    endif()
endif()

# enable Qt

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTORCC ON)
include_directories(${CMAKE_CURRENT_BINARY_DIR})
set(CMAKE_INCLUDE_CURRENT_DIR ON)
if(DEFINED ENV{QTDIR})
    set(CMAKE_PREFIX_PATH "$ENV{QTDIR}")
endif()
find_package(Qt5Core REQUIRED)

# extra setting

include("CMakeExtra.txt" OPTIONAL)

# dependencies

if(${READ_SUBDIRECTORIES})
    add_subdirectory(${VENDOR_PATH}/github.com___qtpm___libgit2 ${CMAKE_BINARY_DIR}/git2)
endif()
include_directories(${VENDOR_PATH}/github.com___qtpm___libgit2/src)


# build setting

include_directories(src)
set(sources src/qgit2/private/annotatedcommit.cpp
    src/qgit2/private/buffer.cpp
    src/qgit2/private/pathcodec.cpp
    src/qgit2/private/remotecallbacks.cpp
    src/qgit2/private/strarray.cpp
    src/qgit2/qgitblob.cpp
    src/qgit2/qgitcheckoutoptions.cpp
    src/qgit2/qgitcherrypickoptions.cpp
    src/qgit2/qgitcommit.cpp
    src/qgit2/qgitconfig.cpp
    src/qgit2/qgitcredentials.cpp
    src/qgit2/qgitdatabase.cpp
    src/qgit2/qgitdatabasebackend.cpp
    src/qgit2/qgitdiff.cpp
    src/qgit2/qgitdiffdelta.cpp
    src/qgit2/qgitdifffile.cpp
    src/qgit2/qgitexception.cpp
    src/qgit2/qgitglobal.cpp
    src/qgit2/qgitindex.cpp
    src/qgit2/qgitindexentry.cpp
    src/qgit2/qgitindexmodel.cpp
    src/qgit2/qgitmergeoptions.cpp
    src/qgit2/qgitobject.cpp
    src/qgit2/qgitoid.cpp
    src/qgit2/qgitrebase.cpp
    src/qgit2/qgitrebaseoptions.cpp
    src/qgit2/qgitref.cpp
    src/qgit2/qgitremote.cpp
    src/qgit2/qgitrepository.cpp
    src/qgit2/qgitrevwalk.cpp
    src/qgit2/qgitsignature.cpp
    src/qgit2/qgitstatus.cpp
    src/qgit2/qgitstatusentry.cpp
    src/qgit2/qgitstatuslist.cpp
    src/qgit2/qgitstatusoptions.cpp
    src/qgit2/qgittag.cpp
    src/qgit2/qgittree.cpp
    src/qgit2/qgittreeentry.cpp)
add_library(qgit2 STATIC ${sources})
qt5_use_modules(qgit2 Core)
target_link_libraries(qgit2 git2)
# install setting

install(TARGETS qgit2 ARCHIVE DESTINATION lib)

set(public_headers__qgit2__private src/qgit2/private/annotatedcommit.h
    src/qgit2/private/buffer.h
    src/qgit2/private/pathcodec.h
    src/qgit2/private/remotecallbacks.h
    src/qgit2/private/strarray.h)
install(FILES ${public_headers__qgit2__private} DESTINATION include/libqgit2/qgit2/private)

set(public_headers src/qgit2.h)
install(FILES ${public_headers} DESTINATION include/libqgit2/)

set(public_headers__qgit2 src/qgit2/credentials_p.h
    src/qgit2/libqgit2_config.h
    src/qgit2/qgitblob.h
    src/qgit2/qgitcheckoutoptions.h
    src/qgit2/qgitcherrypickoptions.h
    src/qgit2/qgitcommit.h
    src/qgit2/qgitconfig.h
    src/qgit2/qgitcredentials.h
    src/qgit2/qgitdatabase.h
    src/qgit2/qgitdatabasebackend.h
    src/qgit2/qgitdiff.h
    src/qgit2/qgitdiffdelta.h
    src/qgit2/qgitdifffile.h
    src/qgit2/qgitexception.h
    src/qgit2/qgitglobal.h
    src/qgit2/qgitindex.h
    src/qgit2/qgitindexentry.h
    src/qgit2/qgitindexmodel.h
    src/qgit2/qgitmergeoptions.h
    src/qgit2/qgitobject.h
    src/qgit2/qgitoid.h
    src/qgit2/qgitrebase.h
    src/qgit2/qgitrebaseoptions.h
    src/qgit2/qgitref.h
    src/qgit2/qgitremote.h
    src/qgit2/qgitrepository.h
    src/qgit2/qgitrevwalk.h
    src/qgit2/qgitsignature.h
    src/qgit2/qgitstatus.h
    src/qgit2/qgitstatusentry.h
    src/qgit2/qgitstatuslist.h
    src/qgit2/qgitstatusoptions.h
    src/qgit2/qgittag.h
    src/qgit2/qgittree.h
    src/qgit2/qgittreeentry.h)
install(FILES ${public_headers__qgit2} DESTINATION include/libqgit2/qgit2)
