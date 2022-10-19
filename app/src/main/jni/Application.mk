APP_PLATFORM = android-21
APP_ABI := all
APP_STL := c++_static
APP_OPTIM := debug


# APP_ABI：默认情况下，NDK 构建系统会为所有非弃用 ABI 生成代码。可以使用 APP_ABI 设置为特定 ABI 生成代码。这会决定ndk编译出的so包数量。推荐至少包含armeabi或armeabi-v7a。
#     不同指令集的 APP_ABI 设置：
#         指令集	                值
#         32 位 ARMv7	            APP_ABI := armeabi-v7a
#         64 位 ARMv8 (AArch64)	APP_ABI := arm64-v8a
#         x86	                    APP_ABI := x86
#         x86-64	                APP_ABI := x86_64
#         所有支持的 ABI（默认）	    APP_ABI := all
#     也可以指定多个值，方法是将它们放在同一行上，中间用空格分隔。例如：APP_ABI := armeabi-v7a arm64-v8a x86
#     Gradle 的 externalNativeBuild 会忽略 APP_ABI。请在 splits 块内部使用 abiFilters 块或（如果使用的是“多个 APK”）abi 块。
# APP_ASFLAGS：项目中每个汇编源文件（.s 和 .S 文件）要传递给编译器的标记。项目中每个程序集源文件要传递给汇编器的标志。
# APP_ASMFLAGS：对所有 YASM 源文件（.asm，仅限 x86/x86_64），要传递给 YASM 的标记。
# APP_BUILD_SCRIPT：如需从其他位置加载 Android.mk 文件，此变量设置为 Android.mk 文件的绝对路径。
#     默认情况下，ndk-build 假定 Android.mk 文件位于项目根目录的相对路径 jni/Android.mk 中。
#     注意：Gradle 的 externalNativeBuild 将根据 externalNativeBuild.ndkBuild.path 变量自动配置此路径。
# APP_CFLAGS：要为项目中的所有 C/C++ 编译传递的标记。注意：Include 路径应使用 LOCAL_C_INCLUDES 而不是显式 -I 标记。
# APP_CLANG_TIDY：若要为项目中的所有模块启用 clang-tidy，请将此标记设置为“True”。默认处于停用状态。
# APP_CLANG_TIDY_FLAGS：要为项目中的所有 clang-tidy 执行传递的标记。
# APP_CONLYFLAGS：要为项目中的所有 C 编译传递的标记。这些标记不会用于 C++ 代码。
# APP_CPPFLAGS：要为项目中的所有 C++ 编译传递的标记。这些标记不会用于 C 代码。
# APP_CXXFLAGS：与 APP_CPPFLAGS 相同，但在编译命令中将出现在 APP_CPPFLAGS 之后。注意：APP_CPPFLAGS 优先于 APP_CXXFLAGS。
#     例如：APP_CPPFLAGS := -DFOO
#         APP_CXXFLAGS := -DBAR
#     以上配置将导致编译命令类似于 clang++ -DFOO -DBAR。
# APP_DEBUG：若要构建可调试的应用，请将此标记设置为“True”。
# APP_LDFLAGS：关联可执行文件和共享库时要传递的标记。这些标记对静态库没有影响。不会关联静态库。
# APP_MANIFEST：AndroidManifest.xml 文件的绝对路径。默认情况下将使用 $(APP_PROJECT_PATH)/AndroidManifest.xml)（如果存在）。
#     注意：使用 externalNativeBuild 时，Gradle 不会设置此值。
# APP_MODULES：要构建的模块的显式列表。此列表的元素是模块在 Android.mk 文件的 LOCAL_MODULE 中显示的名称。
#     填写 so 包的名字，如果没有这个属性，则按照 Android.mk 中的进行命名，注意如果文件中含有多个该属性，则会按照先后顺序为编译出来的so文件命名。
#     默认情况下，ndk-build 将构建所有共享库、可执行文件及其依赖项。仅当项目使用静态库、项目仅包含静态库或者在 APP_MODULES 中指定了静态库时，才会构建静态库。
#     注意：将不会构建导入的模块（在使用 $(call import-module) 导入的构建脚本中定义的模块），除非要在 APP_MODULES 中构建或列出的模块依赖导入的模块。
# APP_OPTIM：此可选变量定义为 release 或 debug。默认情况下，将构建发布二进制文件。
#     发布模式会启用优化，并可能生成无法与调试程序一起使用的二进制文件。
#     调试模式会停用优化，以便可以使用调试程序。
#     注意：可以调试发布二进制文件或调试二进制文件。但是，发布二进制文件在调试期间提供的信息较少。例如，变量可能会被优化掉，导致无法检查代码。此外，代码重新排序会使单步调试代码变得更加困难；堆栈轨迹更可能不可靠。
#     在应用清单的 <application> 标记中声明 android:debuggable 将导致此变量默认为 debug，通过将 APP_OPTIM 设置为 release 可替换此默认值。
#     注意：使用 externalNativeBuild 进行构建时，Android Studio 将根据您的构建风格适当地设置此标记。
# APP_PLATFORM：会声明构建此应用所面向的 Android API 级别，并对应于应用的 minSdkVersion。
#     如果未指定，ndk-build 将以 NDK 支持的最低 API 级别为目标。最新 NDK 支持的最低 API 级别总是足够低，可以支持几乎所有有效设备。
#     将 APP_PLATFORM 设置为高于应用的 minSdkVersion 可能会生成一个无法在旧设备上运行的应用。在大多数情况下，库将无法加载，因为它们引用了在旧设备上不可用的符号。
#     例如，值 android-16 指定库使用在 Android 4.1（API 级别 16）以前的版本中不可用的 API，并且无法在运行较低平台版本的设备上使用。如需查看平台名称和相应 Android 系统映像的完整列表，请参阅 Android NDK 原生 API。
#     使用 Gradle 和 externalNativeBuild 时，不应直接设置此参数。而应在模块级别 build.gradle 文件的 defaultConfig 或 productFlavors 块中设置 minSdkVersion 属性。这样就能确保只有在运行足够高 Android 版本的设备上安装的应用才能使用库。
#     注意：NDK 不包含 Android 每个 API 级别的库，省略了不包含新的原生 API 的版本以节省 NDK 中的空间。ndk-build 按以下优先级降序使用 API：
#         匹配 APP_PLATFORM 的平台版本。
#         低于 APP_PLATFORM 的下一个可用 API 级别。例如，APP_PLATFORM 为 android-20 时，将使用 android-19，因为 android-20 中没有新的原生 API。
#         NDK 支持的最低 API 级别。
#     mac查看所本地ndk版本：/Users/alberthumbert/Library/Android/sdk/ndk-bundle/platforms
# APP_PROJECT_PATH：项目根目录的绝对路径。
# APP_SHORT_COMMANDS：LOCAL_SHORT_COMMANDS 的项目级等效项。参阅 Android.mk 中有关 LOCAL_SHORT_COMMANDS 的文档。
# APP_STL：用于此应用的 C++ 标准库。默认情况下使用 system STL。其他选项包括 c++_shared、c++_static 和 none。
# APP_STRIP_MODE：此应用中的模块要传递给 strip 的参数。默认为 --strip-unneeded。
#     若要避免剥离模块中的所有二进制文件，请将其设置为 none。如需了解其他剥离模式，请参阅剥离文档（https://sourceware.org/binutils/docs/binutils/strip.html）。
# APP_THIN_ARCHIVE：要为项目中的所有静态库使用瘦归档，请将此变量设置为“True”。参阅 Android.mk 中有关 LOCAL_THIN_ARCHIVE 的文档。
# APP_WRAP_SH：要包含在此应用中的 wrap.sh 文件的路径。
#     每个 ABI 都存在此变量的变体，ABI 通用变体也是如此：
#         APP_WRAP_SH
#         APP_WRAP_SH_armeabi-v7a
#         APP_WRAP_SH_arm64-v8a
#         APP_WRAP_SH_x86
#         APP_WRAP_SH_x86_64
#     注意：APP_WRAP_SH_<abi> 可能无法与 APP_WRAP_SH 结合使用。如果有任何 ABI 使用特定于 ABI 的 wrap.sh，所有 ABI 都必须使用该 wrap.sh。