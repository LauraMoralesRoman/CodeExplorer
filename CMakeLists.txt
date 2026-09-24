cmake_minimum_required(VERSION 4.0)

project(code-explorer)

set(CMAKE_C_STANDARD 23)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_subdirectory("${CMAKE_SOURCE_DIR}/vendor/raylib")
add_subdirectory("${CMAKE_SOURCE_DIR}/vendor/cunity")

file(GLOB_RECURSE SOURCES
	CONFIGURE_DEPENDS "${CMAKE_SOURCE_DIR}/src/*.h"
	CONFIGURE_DEPENDS "${CMAKE_SOURCE_DIR}/src/*.c"
)

file(GLOB_RECURSE LIB_SOURCES
	CONFIGURE_DEPENDS "${CMAKE_SOURCE_DIR}/lib/*.h"
	CONFIGURE_DEPENDS "${CMAKE_SOURCE_DIR}/lib/*.c"
)

add_executable("${PROJECT_NAME}" ${SOURCES})
add_library(cslib "${LIB_SOURCES}")

set (TARGETS
	"${PROJECT_NAME}"
	cslib
)

foreach(TARGET ${TARGETS})
	target_compile_options("${PROJECT_NAME}" PRIVATE
		$<$<CONFIG:Debug>:-Wall -Wextra>
		$<$<CONFIG:Debug>:-O0 -ggdb>
		$<$<CONFIG:Debug>:-fsanitize=address>
		$<$<CONFIG:Debug>:-fsanitize=undefined>
		$<$<CONFIG:Release>:-O2 -flto=thin>
	)

	target_link_options("${PROJECT_NAME}" PRIVATE
		$<$<CONFIG:Debug>:-fsanitize=address>
		$<$<CONFIG:Debug>:-fsanitize=undefined>
	)
endforeach()

target_link_libraries("${PROJECT_NAME}" PRIVATE
    raylib cslib
)

target_include_directories("${PROJECT_NAME}" PRIVATE
    "${CMAKE_SOURCE_DIR}/lib"
)

enable_testing()
file(GLOB_RECURSE TEST_SOURCES
	CONFIGURE_DEPENDS "${CMAKE_SOURCE_DIR}/test/*.h"
	CONFIGURE_DEPENDS "${CMAKE_SOURCE_DIR}/test/*.c"
)

add_executable(tests ${TEST_SOURCES}) 

target_link_libraries(tests PRIVATE cunit raylib)

target_include_directories(tests PRIVATE
    "${CMAKE_SOURCE_DIR}/lib"
)
