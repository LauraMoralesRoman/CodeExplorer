#pragma once

typedef enum
{
    CS_LOG_CRITICAL,
    CS_LOG_ERROR,
    CS_LOG_WARN,
    CS_LOG_INFO,
    CS_LOG_DEBUG,
    CS_LOG_TRACE,
} LogLevel;

extern LogLevel CS_LOG_LEVEL;

void CS_log(LogLevel level, ...);
