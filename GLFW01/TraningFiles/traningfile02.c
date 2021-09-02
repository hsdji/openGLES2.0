//
//  traningfile02.c
//  GLFW01
//
//  Created by wuyd on 2021/8/31.
//

#include "GLFWOriginDemo.h"
#include <FWAUserLib/FWAUserLib.h>
void drawContext(double currentAngle);
void errorCallBcak(int a,const char* error);//error call Back

double angle;// 旋转角度
double radius;
GLFWwindow *window;
void drawTriangles(void){
    glfwSetErrorCallback(errorCallBcak);
    GLint success = GL_FALSE;
    angle = 0;
    radius = 0.5;
    success =  glfwInit();
    if (success == GLFW_TRUE) {
        printf("Initialize GLFW Libraby sunccess");
        window = glfwCreateWindow(900, 900, "window", NULL, NULL);
        glfwMakeContextCurrent(window);
        while (!glfwWindowShouldClose(window)) {
            drawContext(angle);
            glfwSwapBuffers(window);
            glfwPollEvents();
            
        }
    }else{
        printf("Initialize GLFW Library Failed!!!");
        glfwTerminate();
    }
    
   
    
}



void errorCallBcak(int a,const char* error){
    printf("%s",error);
}

void drawContext(double currentAngle){
    
//    glClear(GL_COLOR_BUFFER_BIT);
    angle +=0.01;
    glBegin(GL_TRIANGLES);
    
    glColor3f(1, 0, 0);
    glVertex3f(0,0.1, 0);//中心点
    glVertex3f(0.05,0.0, 0);//中心点
    glVertex3f(-0.05,0, 0);//中心点
    
    
    glColor3f(1, 0, 0);// red
    glVertex3f(cos(90 - currentAngle) * radius/2.0,sin(90 - currentAngle) * radius/2.0, 0);//中心点
    glColor3f(0, 1, 0);//blue
    glVertex3f(sin(currentAngle) * radius/2.0, cos(90 - currentAngle) * radius/2.0, 0);//左下角
    glColor3f(0, 0, 1);//green
    glVertex3f(-cos(currentAngle) * radius/2.0,sin(currentAngle)*radius/2.0, 0);
    glEnd();
    
    
}
