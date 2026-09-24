cmake_minimum_required(VERSION 4.0)

project(code-explorer)

set(CMAKE_C_STANDARD 23)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_subdirectory("${CMAKE_SOURCE_DIR}/vendor/raylib")

file(GLOB_RECURSE SOURCES
	CONFIGURE_DEPENDS "${CMAKE_SOURCE_DIR}/src/*.h"
	CONFIGURE_DEPENDS "${CMAKE_SOURCE_DIR}/src/*.c"
)

add_executable("${PROJECT_NAME}" ${SOURCES})

target_compile_options("${PROJECT_NAME}" PRIVATE
    $<$<CONFIG:Debug>:-Wall -Wextra>
    $<$<CONFIG:Debug>:-O0 -ggdb>
    $<$<CONFIG:Debug>:-fsanitize=address>
	$<$<CONFIG:Release>:-O2 -flto=thin>
)

target_link_options("${PROJECT_NAME}" PRIVATE
	$<$<CONFIG:Debug>:-fsanitize=address>
)

target_link_libraries("${PROJECT_NAME}" PRIVATE
    raylib
)
