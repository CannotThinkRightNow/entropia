##################################################
# Build OpenGL Mathematics
##################################################

include(FindPackageHandleStandardArgs)

message(STATUS "Building GLM...")

set(PROJECT_TEMP_DIR "${PROJECT_BINARY_DIR}/tmp")

set(GLM_REPO_API "${PROJECT_TEMP_DIR}/glm/repo.json")
file(DOWNLOAD "https://api.github.com/repos/g-truc/glm" ${GLM_REPO_API} TLS_VERIFY ON)
file(READ ${GLM_REPO_API} GLM_DEFAULT_BRANCH)

string(REGEX MATCH "\"default_branch\": \"(.[^\"])+\"" GLM_DEFAULT_BRANCH ${GLM_DEFAULT_BRANCH})
string(REGEX MATCH " \".+\"" GLM_DEFAULT_BRANCH ${GLM_DEFAULT_BRANCH})
string(REPLACE " \"" "" GLM_DEFAULT_BRANCH ${GLM_DEFAULT_BRANCH})
string(REPLACE "\"" "" GLM_DEFAULT_BRANCH ${GLM_DEFAULT_BRANCH})

set(EXTERNALPROJECT_BUILD_NAME "glm")
set(EXTERNALPROJECT_BUILD_PREFIX "${PROJECT_BINARY_DIR}/external/${EXTERNALPROJECT_BUILD_NAME}")
set(EXTERNALPROJECT_BUILD_CONFIG_ARGS "-Wno-dev -Wno-error=dev -Wno-error=deprecated")
set(EXTERNALPROJECT_BUILD_ARGS ${EXTERNALPROJECT_BUILD_NAME}_project GIT_REPOSITORY "https://github.com/g-truc/glm.git"
                                                                     GIT_TAG "origin/${GLM_DEFAULT_BRANCH}"
                                                                     PREFIX "${EXTERNALPROJECT_BUILD_PREFIX}"
                                                                     CMAKE_ARGS -G "${CMAKE_GENERATOR}" ${PROJECT_ARGS} "-DCMAKE_INSTALL_PREFIX:PATH=${CONTRIB_DIR}" "-DGLM_QUIET:BOOL=${GLM_QUIET}" "-DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS}" "-DBUILD_STATIC_LIBS:BOOL=${BUILD_STATIC_LIBS}" "-DGLM_TEST_ENABLE_CXX_98:BOOL=${GLM_TEST_ENABLE_CXX_98}" "-DGLM_TEST_ENABLE_CXX_11:BOOL=${GLM_TEST_ENABLE_CXX_11}" "-DGLM_TEST_ENABLE_CXX_14:BOOL=${GLM_TEST_ENABLE_CXX_14}" "-DGLM_TEST_ENABLE_CXX_17:BOOL=${GLM_TEST_ENABLE_CXX_17}" "-DGLM_TEST_ENABLE_CXX_20:BOOL=${GLM_TEST_ENABLE_CXX_20}" "-DGLM_TEST_ENABLE_LANG_EXTENSIONS:BOOL=${GLM_TEST_ENABLE_LANG_EXTENSIONS}" "-DGLM_DISABLE_AUTO_DETECTION:BOOL=${GLM_DISABLE_AUTO_DETECTION}" "-DGLM_TEST_ENABLE_FAST_MATH:BOOL=${GLM_TEST_ENABLE_FAST_MATH}" "-DGLM_TEST_ENABLE:BOOL=${GLM_TEST_ENABLE}" "-DGLM_TEST_ENABLE_SIMD_SSE2:BOOL=${GLM_TEST_ENABLE_SIMD_SSE2}" "-DGLM_TEST_ENABLE_SIMD_SSE3:BOOL=${GLM_TEST_ENABLE_SIMD_SSE3}" "-DGLM_TEST_ENABLE_SIMD_SSSE3:BOOL=${GLM_TEST_ENABLE_SIMD_SSSE3}" "-DGLM_TEST_ENABLE_SIMD_SSE4_1:BOOL=${GLM_TEST_ENABLE_SIMD_SSE4_1}" "-DGLM_TEST_ENABLE_SIMD_SSE4_2:BOOL=${GLM_TEST_ENABLE_SIMD_SSE4_2}" "-DGLM_TEST_ENABLE_SIMD_AVX:BOOL=${GLM_TEST_ENABLE_SIMD_AVX}" "-DGLM_TEST_ENABLE_SIMD_AVX2:BOOL=${GLM_TEST_ENABLE_SIMD_AVX2}" "-DGLM_TEST_FORCE_PURE:BOOL=${GLM_TEST_FORCE_PURE}"
                                                                     BUILD_COMMAND ${CMAKE_COMMAND} --build "${EXTERNALPROJECT_BUILD_PREFIX}" --config "${CMAKE_BUILD_TYPE}"
                                                                     GIT_SHALLOW TRUE
                                                                     GIT_PROGRESS TRUE)
include("${PROJECT_SOURCE_DIR}/cmake/ExternalProject_Build/invoke.cmake")
