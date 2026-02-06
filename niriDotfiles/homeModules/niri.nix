{pkgs, inputs, ...}:
{
  programs.niri.enable = true;
  home.packages = with pkgs; [
    alacritty
  ];
}
