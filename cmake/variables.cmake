##################################################
# Variables
##################################################

set(SECTION_HEADER "==================================================")
set(SECTION_SPLITTER "--------------------------------------------------")
set(SECTION_FOOTER "==================================================")

# Environment Variables
if (NOT DEFINED ENV{CI})
  set(ENV{CI} FALSE)
elseif ($ENV{CI} STREQUAL "true" # Travis CI, AppVeyor (Ubuntu)
        OR $ENV{CI} STREQUAL "True") # AppVeyor
  set(ENV{CI} TRUE)
endif ()

if (NOT DEFINED ENV{APPVEYOR})
  set(ENV{APPVEYOR} FALSE)
elseif ($ENV{APPVEYOR} STREQUAL "true" # Ubuntu
        OR $ENV{APPVEYOR} STREQUAL "True")
  set(ENV{APPVEYOR} TRUE)
endif ()

# CMake
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib")
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib")

set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS TRUE)

# Boost
set(Boost_MINIMUM_MINOR_VERSION 44)
set(Boost_MINIMUM_VERSION "1.${Boost_MINIMUM_MINOR_VERSION}.0")
set(Boost_LATEST_MINOR_VERSION 70)
foreach (Boost_MINOR_VERSION RANGE ${Boost_MINIMUM_MINOR_VERSION} ${Boost_LATEST_MINOR_VERSION})
  list(APPEND Boost_ADDITIONAL_VERSIONS "1.${Boost_MINOR_VERSION}")
  list(APPEND Boost_ADDITIONAL_VERSIONS "1.${Boost_MINOR_VERSION}.0")
  if ($ENV{APPVEYOR})
    set(Boost_FIND_DIR "C:/Libraries/boost_1_${Boost_MINOR_VERSION}_0")
    if (EXISTS ${Boost_FIND_DIR} AND IS_DIRECTORY ${Boost_FIND_DIR})
      set(BOOST_ROOT ${Boost_FIND_DIR})
    endif ()
  endif ()
endforeach (${Boost_MINOR_VERSION})
set(Boost_COMPONENTS "filesystem")

# GLFW
set(GLFW_BUILD_DOCS OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_TESTS OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)

# Variables
set(BUILD_SHARED_LIBS TRUE)

if (NOT DEFINED TOOLCHAIN_TAG)
  if (DEFINED CMAKE_TOOLCHAIN_FILE)
    set(TOOLCHAIN_TAG ${CMAKE_TOOLCHAIN_FILE})
  else ()
    message(FATAL_ERROR "CMAKE_TOOLCHAIN_FILE and TOOLCHAIN_TAG are not defined.")
  endif ()
endif ()

string(FIND ${TOOLCHAIN_TAG} "android" ANDROID)
if (${ANDROID} EQUAL -1)
  set(ANDROID FALSE)
else ()
  set(ANDROID TRUE)
endif ()
string(FIND ${TOOLCHAIN_TAG} "ios" IOS)
if (${IOS} EQUAL -1)
  set(IOS FALSE)
else ()
  set(IOS TRUE)
endif ()
string(FIND ${TOOLCHAIN_TAG} "libcxx" UNIX)
if (${UNIX} EQUAL -1)
  set(UNIX FALSE)
else ()
  set(UNIX TRUE)
endif ()
string(FIND ${TOOLCHAIN_TAG} "osx" MACOS)
if (${MACOS} EQUAL -1)
  set(MACOS FALSE)
else ()
  set(MACOS TRUE)
endif ()
string(FIND ${TOOLCHAIN_TAG} "vs" WINDOWS)
if (${WINDOWS} EQUAL -1)
  set(WINDOWS FALSE)
else ()
  set(WINDOWS TRUE)
endif ()

if (ANDROID)
  set(PLATFORM "ANDROID")
elseif (IOS)
  set(PLATFORM "IOS")
elseif (UNIX)
  set(PLATFORM "UNIX")
elseif (MACOS)
  set(PLATFORM "MACOS")
else (WINDOWS)
  set(PLATFORM "WINDOWS")
endif ()

# Messages
message(STATUS ${SECTION_HEADER})
message(STATUS "Variables")
message(STATUS ${SECTION_SPLITTER})
message(STATUS "Name: ${PROJECT_NAME}")
message(STATUS "Version: ${PROJECT_VERSION}")
message(STATUS "Toolchain: ${TOOLCHAIN_TAG}")
message(STATUS "Platform: ${PLATFORM}")
message(STATUS "Continuous Integration: $ENV{CI}")
message(STATUS ${SECTION_FOOTER})
