{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  # nix.settings = {
  #   substituters = [
  #     "https://cuda-maintainers.cachix.org"
  #     ];
  #   trusted-public-keys = [
  #     "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
  #     ];
  # };
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
      libva-utils
      vdpauinfo
      vulkan-loader
      vulkan-tools
      vulkan-validation-layers
      libvdpau-va-gl
      egl-wayland
      wgpu-utils
      libglvnd
      mesa
      libGL
    ];
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  boot.kernelParams = [ "nvidia_drm.fbdev=1" ];
  boot.kernelModules = [ "nvidia-uvm" ];
  environment.systemPackages = with pkgs; [
    libva-utils
    vdpauinfo
    vulkan-loader
    vulkan-tools
    vulkan-validation-layers
    libvdpau-va-gl
    egl-wayland
    wgpu-utils
    libglvnd
    # mesa
    nvtopPackages.full
    libGL
    cudaPackages.cudatoolkit
  ];

  hardware.nvidia = {
    # forceFullCompositionPipeline = true;
    modesetting.enable = true;

    powerManagement.enable = true;
    powerManagement.finegrained = false;

    open = true;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  hardware.nvidia-container-toolkit.enable = true;
  nixpkgs.overlays = [
    (self: super: {
      llama-cpp = super.llama-cpp.override {
        cudaSupport = true;
      };
    })
  ];
}
