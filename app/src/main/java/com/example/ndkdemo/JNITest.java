package com.example.ndkdemo;

/**
 * java 调用对应的 C 代码
 */
public class JNITest {
    static {
        System.loadLibrary("jnitest");
    }
    /**
     * 定义 native 方法
     * 调用 C 代码对应的方法
     */
    public static native int sum(int num1, int num2);

    public native String sayHello();
}
