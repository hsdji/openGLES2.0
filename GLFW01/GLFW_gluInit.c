//
//  GLFW_gluInit.c
//  GLFW01
//
//  Created by wuyd on 2021/8/27.
//

#include "GLFWOriginDemo.h"
void setVertexWithIndex(int index);
int learnGluInit(void){
    int result;
//    Initializes the GLFW library.
//    初始化glfw library
//    调用此函数会清空之前的所有的窗口 和 光标
//    函数返回值 GLFW_TRUE Or GLFW_FALSE
//    该函数只能在主线程中调用
//    注意！！！！ 在程序结束之前 必须要终止glfw (如果你运行之后vs卡死，很可能是忘了终止glfw)
// 目的是为了释放资源，glfwTerminate会销毁窗口释放资源，因此在调用该函数后，如果想使用glfw库函数，就必须重新初始化
    if(glfwInit() == GLFW_TRUE){
        printf("glfw library iniaializes success \n");
        result = 1;
    }else{
        printf("glfw libray initializea failed \n");
        glfwTerminate();//You must be destory this library，if glfw library initializea failed 。
        result = 0;
    }
    GLFWwindow* window  = glfwCreateWindow(480, 320, "Hello World", NULL, NULL);
    /* Make the window's context current */
    glfwMakeContextCurrent(window);
    float index = 0;
    while (!glfwWindowShouldClose(window)) {
        index+= 0.2;
        /* Draw a triangle */
        glBegin(GL_TRIANGLES);
        glColor3f(1.0, 0.0, 0.0);  //red
        setVertexWithIndex(index);
        glColor3f(0.0, 1.0, 0.0);    // Green
        setVertexWithIndex(index+1);
        glColor3f(0.0, 0.0, 1.0);    // Blue
        setVertexWithIndex(index+2);
        glEnd();
        /* Swap front and back buffers */
        glfwSwapBuffers(window);
        /* Poll for and process events */
        glfwPollEvents();
    }
    return  result;
}


void setVertexWithIndex(int index){
    if (index%3 == 0) {
        glVertex3f(0.0, 1.0, 0.0);
    }else if(index%3 == 1){
        glVertex3f(1.0, -1.0, 0.0);
    }else{
        glVertex3f(-1.0, -1.0, 0.0);
    }
}


