{ pkgs, lib, inputs, host, ... }:
with lib;
let
    notInCI = inputs.ci-detector.lib.notInCI == 1;
in
{
    system = {
        activationScripts = {
              preUserActivation.text = ''
              '';
              postUserActivation.text = ''
                ${pkgs.bash}/bin/bash -c '/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u'
              '';
            };
    };
}