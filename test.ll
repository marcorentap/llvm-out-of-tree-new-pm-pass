; ModuleID = 'My module'
source_filename = "My module"

@some_glob = external global i32, align 4

define i32 @some_function(i32 %arg0, i32 %arg1) {
entry:
  %0 = mul i32 %arg0, %arg1
  ret i32 %0
}

define i32 @max(i32 %arg0, i32 %arg1) {
entry:
  %0 = icmp eq i32 %arg0, %arg1
  br i1 %0, label %ret0, label %compGt

ret0:                                             ; preds = %entry
  ret i32 0

compGt:                                           ; preds = %entry
  %1 = icmp sgt i32 %arg0, %arg1
  br i1 %1, label %retArg0, label %retArg1

retArg0:                                          ; preds = %compGt
  ret i32 %arg0

retArg1:                                          ; preds = %compGt
  ret i32 %arg1
}

define i32 @max2(i32 %arg0, i32 %arg1) {
entry:
  %0 = icmp eq i32 %arg0, %arg1
  br i1 %0, label %ret, label %cmp

cmp:                                              ; preds = %entry
  %1 = icmp sgt i32 %arg0, %arg1
  br i1 %1, label %setRetArg0, label %setRetArg1

setRetArg0:                                       ; preds = %cmp
  br label %ret

setRetArg1:                                       ; preds = %cmp
  br label %ret

ret:                                              ; preds = %setRetArg1, %setRetArg0, %entry
  %phi = phi i32 [ 0, %entry ], [ %arg0, %setRetArg0 ], [ %arg1, %setRetArg1 ]
  ret i32 %phi
}

define i32 @max_square(i32 %arg0, i32 %arg1) {
entry:
  %0 = icmp eq i32 %arg0, %arg1
  br i1 %0, label %merge, label %retArg0Squared

retArg0Squared:                                   ; preds = %entry
  %1 = mul i32 %arg0, %arg0
  %2 = icmp sgt i32 %arg0, %arg1
  br i1 %2, label %merge, label %retArg1Squared

retArg1Squared:                                   ; preds = %retArg0Squared
  %3 = mul i32 %arg1, %arg1
  br label %merge

merge:                                            ; preds = %retArg1Squared, %retArg0Squared, %entry
  %phi = phi i32 [ 0, %entry ], [ %1, %retArg0Squared ], [ %3, %retArg1Squared ]
  ret i32 %phi
}
