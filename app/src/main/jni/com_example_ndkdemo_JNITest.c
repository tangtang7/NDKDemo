//
// Created by whh on 2022/10/18.
//
#include "jni.h"    // 该头文件包含了对jni数据类型和接口的定义，所有C/C++代码都需要引入这个头文件。
#include "com_example_ndkdemo_JNITest.h"

JNIEXPORT jint JNICALL Java_com_example_ndkdemo_JNITest_sum(JNIEnv * env, jclass class, jint num1, jint num2) {
    return num1 + num2;
}

JNIEXPORT jstring JNICALL Java_com_example_ndkdemo_JNITest_sayHello(JNIEnv * env, jobject object) {
    char * text = "I am from C";
    return (*env)->NewStringUTF(env,text);
}