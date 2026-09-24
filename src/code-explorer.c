#include "raylib.h"
#include "sqlite3.h"

int main(int argc, char** argv)
{
    InitWindow(800, 600, "Code Explorer");
    SetTargetFPS(60);

    while (!WindowShouldClose())
    {
        BeginDrawing();
        EndDrawing();
    }

    CloseWindow();
}
