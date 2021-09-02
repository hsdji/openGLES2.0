//
//  TraningGLFWLibraryInit.c
//  GLFW01
//
//  Created by wuyd on 2021/8/29.
//

#include "GLFWOriginDemo.h"
GLboolean setCurrentContext(void);
void drawRect(GLFWwindow *window);
void createRect(GLFWwindow *window);

GLboolean initializeaGLFWLibrary(void){
    GLboolean initializeaSuccess = GLFW_TRUE;
    
    GLint initializeaSatate = glfwInit();
    if (initializeaSatate == GLFW_TRUE) {
        printf("glfw library iniaitlizeaed sunccess");
        return setCurrentContext();
    }else{
        printf("glfw linrary iniaitlizeaed failed");
        glfwTerminate();
    }
    return initializeaSuccess;
}

GLboolean setCurrentContext(void){
    GLboolean success = GL_FALSE;
    GLFWwindow *window = glfwCreateWindow(320, 480, "this is the Traning init", NULL, NULL);
    glfwMakeContextCurrent(window);
    while(!glfwWindowShouldClose(window)) {
        success = GL_TRUE;
        drawRect(window);
        createRect(window);
    }
    return success;
}


void drawRect(GLFWwindow *window){
    glBegin(GL_TRIANGLES);
    glColor3f(1.0, 0.0, 0.0); // Red
    glVertex3f(-0.5, 0.5, 0.0);// 左上角
    glVertex3f(0.5, -0.5, 0.0);//(0.5,-0.5,0);
    glVertex3f(-0.5, -0.5, 0.0);
    glColor3f(1, 1, 1); // Blue
    glVertex3f(-0.5, 0.5, 0);
    glVertex3f(0.5, 0.5, 0);
    glVertex3f(0.5, -0.5, 0);
    glColor3f(0, 0, 0.5);
    glEnd();
    /* Swap front and back buffers */
    glfwSwapBuffers(window);
    /* Poll for and process events */
    glfwPollEvents();
}


void createRect(GLFWwindow *window){
    
  glBegin(GL_TRIANGLES);
    
  glColor3f(0, 1, 0);
  glVertex3f(-1, 1, 0);
  glVertex3f(-1, -1, 0);
  glVertex3f(1, -1, 0);
  
  glVertex3f(1, -1, 0);
  glVertex3f(1, 1, 0);
  glVertex3f(-1, 1, 0);
  glEnd();
    
  glfwSwapBuffers(window);
  glfwPollEvents();
}

