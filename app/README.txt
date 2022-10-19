1.	在 Java 里面写 native 代码。创建java文件，声明自定义native方法，该方法就是java层到native层的入口。
    Java 代码：
        package com.example.ndkdemo;
        public class JNITest{
            static{
                System.loadLibrary("sotest");
          }
          public static native int sum(int num1, int num2);
          public native String sayHello();
        }
2.	根据native方法签名及类信息生成的头文件。可以使用javah命令生成，或自行编写。
    1) 使用命令生成：
    	//在终端 terminal 中
    	cd app/src/main/java
    	javac com/example/ndkdemo/JNITest.java（java类的路径） --> 生成JniUtil.classs
    	javah com.example.ndkdemo.JNITest（全类名）
    	生成的头文件：见 com_example_ndkdemo_JNITest.h
    2) 导出头文件注意事项：
        1. 类名要使用全路径类名，不能带扩展名（.class）
        2. 要处于合适的目录（即java下）
        3. 正确设置工作类路径
        4. 正确设定系统类路径
    3） 自行编写：
        预处理指令的写法都是相同的，将完整类名替换进去即可。
        对于函数签名，从左到右按以下顺序编写：
        •	JNIEXPORT： 在android和linux中是空定义的宏，而在windows下被定义为__declspec(dllexport)，具体的作用我们不需要关心
        •	jni数据类型：如jint，jboolean，jstring，它们对应于本地方法的返回类型（int，boolean，String）
        •	JNICALL： 这是__stdcall等函数调用约定（calling conventions）的宏，这些宏用于提示编译器该函数的参数如何入栈（从左到右，从右到左），以及清理堆栈的方式等
        •	方法名： Java +完整类名 +方法名
        •	参数列表：JNIEnv *+jclass\jobject +所有你定义的参数所对应的jni数据类型 ，JNIEnv*是指向jvm函数表的指针，如果该方法为静态方法则第二个参数为class否则为jobject，它是含有该方法的class对象或实例。
        •	注意：JNIEXPORT和JNICALL是固定的。
3.	编写 C/C++代码。需要包含两个头文件：jni.h 和 2. 生成的头文件。
    内容见 com_example_ndkdemo_JNITest.c。
4.	在main包下创建一个jni包，将 2. 头文件、 3. c/c++文件、5. Android.mk 文件、6. Application.mk 文件放进去。
    （mk文件是makefile文件的一部分，makefile包含c/c++编译器的编译命令、顺序和规则）
5.	编写 Android.mk 文件。
    解析与使用 见 Android.mk。
6.	编写 Application.mk 文件。
    解析与使用 见 Application.mk。
7.	在 gradle 中指定 so 库的路径，gradle 会自动将 so 文件打包进来，在 andorid 闭包中添加
        android {
            defaultConfig {}      // 在 defaultConfig 内或外均可
            sourceSets.main {
                jniLibs.srcDir 'src/main/libs'
                jni.srcDirs = []
            }
        }
8.	编译成动态链接库文件：在 Terminal 中进入 jni 文件夹目录，输入命令 ndk-build，即可生成 lib+moduleName.so 文件。
        • 若 Application.mk 中通过 APP_PLATFORM 指定的版本与 AndroidManifest.xml 不同（或 AndroidManifest 未指定），则需要在 AndroidManifest.xml 中添加代码：
            <manifest …>
                <uses-sdk android:minSdkVersion="21"/>
                // <uses-sdk android:minSdkVersion="21" android:targetSdkVersion="32"/>
                <application …/>
            </manifest>
9.	在 Java 中用 System.loadLibrary() 方法加载产生的动态链接库文件，使用静态域将so包加载进来。这个 native 方法就可以在 Java 中被访问了。
        static {
            System.loadLibrary("jnitest");
        }