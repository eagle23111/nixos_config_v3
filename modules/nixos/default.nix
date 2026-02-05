{
  nix-ld = import ./nix-ld.nix;
  nvidia = import ./nvidia.nix;
  qemu = import ./qemu.nix;
  consoleUtils = import ./consoleUtils.nix;
  desktopTemp = import ./desktop_temp.nix;
}
