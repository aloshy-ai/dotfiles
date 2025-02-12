{lib, inputs, ...}:
with lib; rec {
    mkIfElse = p: yes: no: mkMerge [
      (mkIf p yes)
      (mkIf (!p) no)
    ];

    InCI = inputs.ci-detector.lib.inCI == 1;
    notInCI = inputs.ci-detector.lib.notInCI == 1;
 }