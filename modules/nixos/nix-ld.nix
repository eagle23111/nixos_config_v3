{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = [
    config.hardware.graphics.package
    pkgs.glibc
    pkgs.glib
    pkgs.stdenv.cc.cc.lib
    pkgs.glibc
    pkgs.zlib
    pkgs.libgcc
    pkgs.libGL
    pkgs.libgccjit
    config.boot.kernelPackages.nvidiaPackages.stable
    pkgs.cudaPackages.cudatoolkit
  ];
}
