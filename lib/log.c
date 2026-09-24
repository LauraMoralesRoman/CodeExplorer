#include "log.h"

#include <stdarg.h>
#include <stdlib.h>

LogLevel CS_LOG_LEVEL = CS_LOG_INFO;

void CS_log(LogLevel level, ...)
{
    if (level < CS_LOG_LEVEL)
        return;

    if (CS_LOG_CRITICAL == level)
        exit(1);
}
