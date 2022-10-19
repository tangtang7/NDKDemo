//
// Created by whh on 2022/10/17.
//

#include "Hello.h"
#include <stdio.h>
#include <stdlib.h>
#include <jni.h>

/**
 * jstring - 返回值
 * Java_全类名_方法名
 * JNIEnv* env - 二级指针，环境变量。里面有很多方法。
 * jobject jobj - 谁调用了这个方法，就是谁的实例。当前为 JNITest.this
 */
 // typedef const struct JNINativeInterface_ *JNIEnv;
jstring Java_com_example_ndkdemo_JNITest_sayHello(JNIEnv* env,jobject jobj) {
    // jstring (JNICALL *NewStringUTF) (JNIEnv *env, const char *utf);
    char * text = "I am from C";
    return (*env)->NewStringUTF(env,text);
}
