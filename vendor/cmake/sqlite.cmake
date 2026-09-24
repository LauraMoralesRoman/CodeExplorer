find_program(MAKE_EXECUTABLE make REQUIRED)

set(SQLITE_SOURCE_DIR
    "${CMAKE_SOURCE_DIR}/vendor/sqlite"
    CACHE PATH "SQLite source directory"
)

set(SQLITE_BUILD_DIR
    "${CMAKE_CURRENT_BINARY_DIR}/sqlite-build"
)

set(SQLITE3_C
    "${SQLITE_BUILD_DIR}/sqlite3.c"
)

set(SQLITE3_H
    "${SQLITE_BUILD_DIR}/sqlite3.h"
)

add_custom_command(
    OUTPUT
        "${SQLITE3_C}"
        "${SQLITE3_H}"

    COMMAND
        "${CMAKE_COMMAND}" -E make_directory
        "${SQLITE_BUILD_DIR}"

    COMMAND
        "${SQLITE_SOURCE_DIR}/configure"
        --disable-shared
        --enable-static

    COMMAND
        "${MAKE_EXECUTABLE}"
        sqlite3.c

    WORKING_DIRECTORY
        "${SQLITE_BUILD_DIR}"

    DEPENDS
        "${SQLITE_SOURCE_DIR}/configure"

    COMMENT "Generating SQLite amalgamation"
    VERBATIM
)

add_library(sqlite3 STATIC
    "${SQLITE3_C}"
)

target_include_directories(sqlite3
    PUBLIC
        "${SQLITE_BUILD_DIR}"
)

set_target_properties(sqlite3 PROPERTIES
    C_STANDARD 99
    C_STANDARD_REQUIRED ON
)

add_library(SQLite::SQLite3 ALIAS sqlite3)
