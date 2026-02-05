{pkgs, inputs, ...}:
{
  imports = [
    inputs.niri.homeModules.niri
  ];
  programs.niri = {
    settings = {
      outputs."DP-1" = {
        mode.refresh = 179.999;
      };
    };
  };
}
