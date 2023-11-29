# mojo_repro

Trying to reproduce a bug originally found in <https://github.com/ConnorBaker/mojo_rt/commit/3a041e789656bcd5f02579fb7ede573dc757cb84>.

## Bug 1

Run `make main1` to see the bug. The output should be:

```console
% make main1
make: Running main1...
Please submit a bug report to https://github.com/modularml/mojo/issues and include the crash backtrace along with all the relevant source codes.
Stack dump:
0.	Program arguments: mojo run main1.mojo
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  mojo                     0x0000000104a32fc0 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 56
1  mojo                     0x0000000104a31120 llvm::sys::RunSignalHandlers() + 112
2  mojo                     0x0000000104a3365c SignalHandler(int) + 344
3  libsystem_platform.dylib 0x0000000184c74a24 _sigtramp + 56
4  libsystem_platform.dylib 0x000000028003405c _sigtramp + 4215010928
5  libsystem_platform.dylib 0x0000000280034298 _sigtramp + 4215011500
6  mojo                     0x0000000104de33e0 M::KGEN::ExecutionEngine::runProgram(llvm::StringRef, llvm::StringRef, llvm::function_ref<M::ErrorOrSuccess (void*)>) + 212
7  mojo                     0x000000010498d210 run(M::State const&) + 4052
8  mojo                     0x0000000104976c30 main + 1088
9  dyld                     0x00000001848c50e0 start + 2360
[63133:1208786:20231129,012705.698859:WARNING crash_report_exception_handler.cc:257] UniversalExceptionRaise: (os/kern) failure (5)
make: *** [main1] Segmentation fault: 11
```

## Bug 2

Run `make main2` to see the bug. The output should be:

```console
% make main2
make: Running main2...
Assertion failed: (llvm::isPowerOf2_64(alignment) && "non-power-of-2 alignment!"), function alignedAlloc, file AlignedAlloc.cpp, line 13.
Please submit a bug report to https://github.com/modularml/mojo/issues and include the crash backtrace along with all the relevant source codes.
Stack dump:
0.	Program arguments: mojo run main2.mojo
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  mojo                          0x0000000100adefc0 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 56
1  mojo                          0x0000000100add120 llvm::sys::RunSignalHandlers() + 112
2  mojo                          0x0000000100adf65c SignalHandler(int) + 344
3  libsystem_platform.dylib      0x0000000184c74a24 _sigtramp + 56
4  libsystem_pthread.dylib       0x0000000184c44cc0 pthread_kill + 288
5  libsystem_c.dylib             0x0000000184b50a40 abort + 180
6  libsystem_c.dylib             0x0000000184b4fd30 err + 0
7  libKGENCompilerRTShared.dylib 0x000000010835ca00 M::Error::Error(llvm::Twine) (.cold.1) + 0
8  libKGENCompilerRTShared.dylib 0x000000010832eafc M::Error::Error(llvm::Twine) + 0
9  libKGENCompilerRTShared.dylib 0x00000002800342dc M::Error::Error(llvm::Twine) + 6305109984
10 libKGENCompilerRTShared.dylib 0x00000002800342a0 M::Error::Error(llvm::Twine) + 6305109924
11 mojo                          0x0000000100e8f3e0 M::KGEN::ExecutionEngine::runProgram(llvm::StringRef, llvm::StringRef, llvm::function_ref<M::ErrorOrSuccess (void*)>) + 212
12 mojo                          0x0000000100a39210 run(M::State const&) + 4052
13 mojo                          0x0000000100a22c30 main + 1088
14 dyld                          0x00000001848c50e0 start + 2360
[63141:1209033:20231129,012720.756112:WARNING crash_report_exception_handler.cc:257] UniversalExceptionRaise: (os/kern) failure (5)
make: *** [main2] Abort trap: 6
```

## Bug 3

Run `make main3_merge_transforms_1` to see the bug. The output should be:

```console
% make main3_merge_transforms_1
make: Running main3 with MOJO_MERGE_FN_NAME=merge_transforms_1...
value: 3.0
make: Done.
```

Note that this value is incorrect. The merged transform is equivalent to `x -> 32x + 57`, so with `x = 1.0` we should get `89.0`.

Worse though, `make main3_merge_transforms_2` yields another error:

```console
% make main3_merge_transforms_2
make: Running main3 with MOJO_MERGE_FN_NAME=merge_transforms_2...
Please submit a bug report to https://github.com/modularml/mojo/issues and include the crash backtrace along with all the relevant source codes.
Stack dump:
0.	Program arguments: mojo run main3.mojo
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  mojo                     0x000000010049efc0 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 56
1  mojo                     0x000000010049d120 llvm::sys::RunSignalHandlers() + 112
2  mojo                     0x000000010049f65c SignalHandler(int) + 344
3  libsystem_platform.dylib 0x0000000184c74a24 _sigtramp + 56
4  libsystem_platform.dylib 0x00000002800347f4 _sigtramp + 4215012872
5  mojo                     0x000000010084f3e0 M::KGEN::ExecutionEngine::runProgram(llvm::StringRef, llvm::StringRef, llvm::function_ref<M::ErrorOrSuccess (void*)>) + 212
6  mojo                     0x00000001003f9210 run(M::State const&) + 4052
7  mojo                     0x00000001003e2c30 main + 1088
8  dyld                     0x00000001848c50e0 start + 2360
[63325:1216768:20231129,013808.176438:WARNING crash_report_exception_handler.cc:257] UniversalExceptionRaise: (os/kern) failure (5)
make: *** [main3_merge_transforms_2] Segmentation fault: 11
```