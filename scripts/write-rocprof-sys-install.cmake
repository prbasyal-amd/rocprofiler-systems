cmake_minimum_required(VERSION 3.18.4)

if(NOT DEFINED ROCPROFSYS_VERSION)
    file(READ "${CMAKE_CURRENT_LIST_DIR}/../VERSION" FULL_VERSION_STRING LIMIT_COUNT 1)
    string(REGEX REPLACE "(\n|\r)" "" FULL_VERSION_STRING "${FULL_VERSION_STRING}")
    string(REGEX REPLACE "([0-9]+)\.([0-9]+)\.([0-9]+)(.*)" "\\1.\\2.\\3"
                         ROCPROFSYS_VERSION "${FULL_VERSION_STRING}")
endif()

find_package(Git)

if(Git_FOUND AND EXISTS ".git")
    execute_process(
        COMMAND ${GIT_EXECUTABLE} describe --tags
        OUTPUT_VARIABLE ROCPROFSYS_GIT_TAG
        OUTPUT_STRIP_TRAILING_WHITESPACE
        RESULT_VARIABLE _GIT_DESCRIBE_RESULT
        ERROR_QUIET)
    if(NOT _GIT_DESCRIBE_RESULT EQUAL 0)
        execute_process(
            COMMAND ${GIT_EXECUTABLE} describe
            OUTPUT_VARIABLE ROCPROFSYS_GIT_TAG
            OUTPUT_STRIP_TRAILING_WHITESPACE
            RESULT_VARIABLE _GIT_DESCRIBE_RESULT
            ERROR_QUIET)
    endif()
else()
    message(
        STATUS
            "Git not found or .git directory not found; using version ${ROCPROFSYS_VERSION}"
        )
    set(GIT_DESCRIBE "v${ROCPROFSYS_VERSION}")
endif()

if(NOT DEFINED OUTPUT_DIR)
    set(OUTPUT_DIR ${CMAKE_CURRENT_LIST_DIR})
endif()

message(STATUS "Writing ${OUTPUT_DIR}/rocprofiler-systems-install.py.")
message(STATUS "rocprofiler-systems version: ${ROCPROFSYS_VERSION}.")
message(STATUS "rocprofiler-systems git describe: ${ROCPROFSYS_GIT_TAG}")

configure_file(${CMAKE_CURRENT_LIST_DIR}/../cmake/Templates/rocprof-sys-install.py.in
               ${OUTPUT_DIR}/rocprofiler-systems-install.py @ONLY)
