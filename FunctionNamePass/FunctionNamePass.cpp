#include <llvm/IR/PassManager.h>
#include <llvm/Passes/PassBuilder.h>
#include <llvm/Passes/PassPlugin.h>

namespace llvm {

class FunctionNamePass : public PassInfoMixin<FunctionNamePass> {
public:
  char ID;
  PreservedAnalyses run(Function &F, FunctionAnalysisManager &FAM) {
    errs() << "Found function: " << F.getName() << "\n";
    return PreservedAnalyses::all();
  }
};

extern "C" PassPluginLibraryInfo llvmGetPassPluginInfo() {
  return {LLVM_PLUGIN_API_VERSION, "FunctionNamePass", "V0.1",
          [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef passName, FunctionPassManager &FPM, ...) {
                  if (passName == "function-name-pass") {
                    FPM.addPass(FunctionNamePass());
                    return true;
                  }
                  return false;
                });
          }};
}

} // namespace llvm
