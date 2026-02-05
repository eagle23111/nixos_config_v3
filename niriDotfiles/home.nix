{ pkgs, inputs, ... }:

{
  imports = [
    ./homeModules/dms.nix
    ./homeModules/niri.nix
  ];
}