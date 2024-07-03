# Usage

```
clang -emit-llvm -O1 -S -o test.ll test.cpp
```

assuming that's in the build directory,

```
opt -load-pass-plugin ./PrintFunctionName/libPrintFunctionName.so -p=print-function-name test.ll
```

or add `-save-temps` to cxx flags and use the .bc file
