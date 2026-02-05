{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.self.nixosModules.consoleUtils
    inputs.self.nixosModules.nix-ld
    inputs.self.nixosModules.nvidia
    inputs.self.nixosModules.qemu

    inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    ./hardware-configuration.nix
    ./boot.nix
  ];

  nixpkgs = {
    overlays = [
      inputs.self.overlays.additions
      inputs.self.overlays.modifications
      inputs.self.overlays.unstable-packages

      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    config = {
      allowUnfree = true;
    };
  };

  boot.extraModprobeConfig = ''
    options hid_apple fnmode=0
  '';

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      experimental-features = "nix-command flakes";
      flake-registry = "";
      nix-path = config.nix.nixPath;
    };
    channel.enable = false;

    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };
  # TODO: set a proper desktop shell
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  
  # TODO: probably move it somewhere else
  fonts.packages = with pkgs; [ nerd-fonts.terminess-ttf ];

  

  services.pipewire = {
     enable = true;
     pulse.enable = true;
   };
  i18n.defaultLocale = "ru_RU.UTF-8";
  i18n.supportedLocales = [ "ru_RU.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" ];
  console.useXkbConfig = true;

  services.xserver.xkb.layout = "us,ru";
  services.xserver.xkb.options = "grp:alt_shift_toggle";
  networking.hostName = "nixos";
  time.timeZone = "Europe/Moscow";

  users.users = {
    mortal = {
      isNormalUser = true;
      extraGroups = ["wheel" "gamemode"];
    };
  };
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
    };
  };

  system.stateVersion = "25.11";
}
