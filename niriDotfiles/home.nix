{ pkgs, inputs, ... }:

{
  imports = [
    ./homeModules/dms.nix
    ./homemodules/niri.nix
  ];
}