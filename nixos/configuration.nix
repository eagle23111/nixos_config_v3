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
    inputs.self.nixosModules.gaming
    inputs.self.nixosModules.bypassCen
    inputs.hardware.nixosModules.common-cpu-amd

    #inputs.self.gnome.nixosModule
    inputs.self.niri.nixosModule

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

  # TODO: probably move it somewhere else
  fonts.packages = with pkgs; [nerd-fonts.terminess-ttf pkgs.terminus_font];
  #services.flatpak.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  i18n.defaultLocale = "ru_RU.UTF-8";
  i18n.extraLocales = ["ru_RU.UTF-8/UTF-8" "en_US.UTF-8/UTF-8"];
  console = {
    useXkbConfig = true;
    earlySetup = true;
    font = "cyr-sun16";
    packages = [pkgs.powerline-fonts];
  };

  services.xserver.xkb.layout = "us,ru";
  services.xserver.xkb.options = "grp:alt_shift_toggle";
  networking.hostName = "nixos";
  time.timeZone = "Europe/Moscow";
  security.pam.services.gdm.enableGnomeKeyring = true;
  users.users = {
    mortal = {
      isNormalUser = true;
      extraGroups = ["wheel" "gamemode" "libvirtd" "kvm"];
    };
  };
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  environment.variables = {
    PATH = builtins.getEnv "PATH" + ":~/.local/bin";
    # Example for ~/.local/bin (ensure it gets added at system boot)
    # environment.localBinInPath = true; # There may be a dedicated option for this
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
    };
  };
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/mortal/nixosRelated/nixos-flake-current"; # sets NH_OS_FLAKE variable for you
  };
  system.stateVersion = "25.11";
}
