LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE    := jnitest
LOCAL_SRC_FILES := com_example_ndkdemo_JNITest.c

include $(BUILD_SHARED_LIBRARY)

# 1. Android.mk必须以 LOCAL_PATH 开头，它用于指定源文件的路径。构建系统提供的宏函数 my-dir 将返回当前目录（Android.mk 文件本身所在的目录）的路径。
#     $(call my-dir) 表示调用这个函数。
# 2. CLEAR_VARS 变量指向一个特殊的 GNU Makefile，负责文件的清理，清除了 LOCAL_PATH 变量之外的 LOCAL_XXX 变量，例如 LOCAL_MODULE、LOCAL_SRC_FILES 和 LOCAL_STATIC_LIBRARIES。
#     所有的编译控制文件都在同一个GNU MAKE执行环境中，所有的变量都是全局的，在编译该模块之前可能编译过别的模块，产生了大量变量，会被系统误认为是属于该模块的，可能产生不可预知的错误。
#     注意：LOCAL_PATH 变量必须保留，因为系统在单一 GNU Make 执行上下文（其中的所有变量都是全局变量）中解析所有构建控制文件。在描述每个模块之前，必须（重新）声明此变量。
# 3. LOCAL_MODULE 变量存储要构建的模块的名称。请在应用的每个模块中使用一次此变量。每个模块名称必须唯一，且不含任何空格。
#     构建系统在生成最终共享库文件时，会对分配给 LOCAL_MODULE 的名称自动添加正确的前缀和后缀。例如，上述示例会生成名为 libjnitest.so 的库。
#     注意：如果模块名称的开头已经是 lib，构建系统不会添加额外的 lib 前缀；而是按原样采用模块名称，并添加 .so 扩展名。
#     比如原来名为 libfoo.c 的源文件会生成名为 libfoo.so 的共享对象文件。
#     此行为是为了支持 Android 平台源文件根据 Android.mk 文件生成的库；所有这些库的名称都以 lib 开头。
# 4. LOCAL_SRC_FILES 变量代表需要编译的文件，列举需要编译 C 和/或 C++ 源文件，包含要构建到模块中的源文件列表，以空格分隔多个文件，如无后缀则默认为cpp文件。
#     几个常用的获取源文件的方法：
#         $(call all-java-files-under, src) ：获取指定目录下的所有 Java 文件。
#         $(call all-c-files-under, src) ：获取指定目录下的所有 C 语言文件。
#         $(call all-Iaidl-files-under, src) ：获取指定目录下的所有 AIDL 文件。
#         $(call all-makefiles-under, folder)：获取指定目录下的所有 Make 文件。
# 5. BUILD_SHARED_LIBRARY 变量指向一个 GNU Makefile 脚本，该脚本会收集自最近 include 以来在 LOCAL_XXX 变量中定义的所有信息，并确定要构建的内容以及构建方式。
#   收集上次清理后的源文件信息，并决定如何编译，帮助系统将一切连接到一起。
#     include $(BUILD_STATIC_LIBRARY) ：编译成静态库
#     include $(BUILD_SHARED_LIBRARY) ：编译成动态库
#     include $(BUILD_EXECUTABLE) ：编译成可执行程序
#     include $(BUILD_STATIC_JAVA_LIBRARY) ：编译成Java静态库
# 选填举例，详细可见5）标题链接的官方文档：
# 6. 编译的标签: LOCAL_MODULE_TAGS := optional
#     常用的有：debug, eng, user，development 或者 optional（默认）。
# 7. 签名属性: LOCAL_CERTIFICATE := platform
#     常用的有：
#         platform：该 APK 完成一些系统的核心功能。经过对系统中存在的文件夹的访问测试。
#         shared：该APK需要和 home/contacts 进程共享数据。
#         media：该APK是 media/download 系统中的一环。
# 8. 引用jar库。LOCAL_STATIC_JAVA_LIBRARIES 引用静态jar库。LOCAL_JAVA_LIBRARIES 引用动态jar库。
#     LOCAL_STATIC_JAVA_LIBRARIES := jar1 jar2
#     jar1、jar2 是第三方 Java 包的别名，需要定义，见9。
# 9. 需要进行预编译的库
#     LOCAL_PREBUILT_STATIC_JAVA_LIBRARIES := jar1:path1 \
#                                             jar2:path2
#     jar1、jar2 定义静态库别名，path1、path2 是静态库的路径，注意要一直写到后缀 .jar.。
# 10. 拷贝到本地编译: include $(BUILD_MULTI_PREBUILT)
#     将 prebuild 定义的库拷到本地进行编译。
# 11. 指定生成 apk 的目录: LOCAL_MODULE_PATH := $(TARGET_OUT)/
#     $(TARGET_OUT) 代表 /system ，后续路径按需要补充完整
#     $(TARGET_OUT_DATA_APPS) 代表 data/app 目录
# 12. 头文件的搜索路径: LOCAL_C_INCLUDES := sources/foo
#     指定相对于 NDK root 目录的路径列表，以便在编译所有源文件（C、C++ 和 Assembly）时添加到 include 搜索路径中。
# 13. TARGET_ARCH，指定AB
#     构建系统解析此 Android.mk 文件时指向的 CPU 系列。此变量将是下列其中一项：arm、arm64、x86 或 x86_64。
# 14. 构建系统提供许多可在 Android.mk 文件中使用的变量。除了已预先赋值的变量之外，还可以自己定义任意变量（建议在名称前附加 MY_）。
#     在定义变量时请注意，NDK 构建系统保留了下列变量名称：
#         以 LOCAL_ 开头的名称，例如 LOCAL_MODULE。
#         以 PRIVATE_、NDK_ 或 APP 开头的名称。构建系统在内部使用这些变量名。
#         小写名称，例如 my-dir。构建系统也是在内部使用这些变量名。
