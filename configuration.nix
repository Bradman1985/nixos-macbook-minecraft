{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Boot configuration (Legacy Boot)
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda"; # Adjust if needed

  # Pin kernel to 5.15 for Nvidia 340 compatibility
  boot.kernelPackages = pkgs.linuxPackages_5_15;

  # Hardware
  hardware.enableRedistributableFirmware = true;

  # Nvidia 9400M configuration
  hardware.nvidia = {
    modesetting.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.legacy_340;
  };
  services.xserver.videoDrivers = [ "nvidia" ];

  # Networking
  networking.hostName = "macbook-server";
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 25565 25566 25567 25568 ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System packages
  environment.systemPackages = with pkgs; [ htop vim git gh ];

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # System version
  system.stateVersion = "24.11"; # Adjust as needed
}
​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​
