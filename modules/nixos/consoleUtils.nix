{
  pkgs,
  inputs,
  ...
}: {
  #TODO: move linux-only packages somewhere
  environment.systemPackages = with pkgs; [
    which
    tree
    wget
    inputs.nvchad4nix.packages.${system}.default
    btop
    iotop
    iftop
    strace
    ltrace
    lsof
    nix-index
    zip
    unzip
    xz
    p7zip
    lm_sensors
    ethtool
    pciutils
    usbutils
    nixfmt-rfc-style
    aria2
    fastfetch
    inputs.home-manager.packages.${pkgs.system}.default
  ];

  programs.git.enable = true;
}
