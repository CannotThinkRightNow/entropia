#include "logging.h"
#include "main.h"
#include "graphics.h"

namespace logUtility = logging::utility;

int main(int argc, char** argv)
{
    logUtility::printArgs(CLIENT_ID, argc, argv);
    createWindow();
    glInit();

    while (!glfwWindowShouldClose(window))
    {
        glfwSwapBuffers(window);
        glfwPollEvents();
        if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS)
            glfwSetWindowShouldClose(window, GL_TRUE);
    }

    glfwTerminate();
    return 0;
}
