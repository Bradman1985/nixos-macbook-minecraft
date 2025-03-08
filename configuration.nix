{ config, lib, pkgs, ... }:
{
  imports = [ ./secrets.nix ];

  # Bootloader (preserve macOS)
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda"; # Adjust if needed

  # Kernel optimized for old Mac hardware
  boot.kernelPackages = pkgs.linuxPackages_5_15;
  boot.kernelParams = [ "intel_pstate=disable" ];

  # Fan control and performance
  hardware.enableAllFirmware = true;
  services.mbpfan.enable = true;
  services.mbpfan.settings = {
    low_temp = 50;
    high_temp = 70;
    max_temp = 85;
    max_fan_speed = 6200; # Adjust for your MacBook model
  };
  powerManagement.powertop.enable = false;

  # Networking
  networking.hostName = "macbook-server";
  networking.wireless.enable = true;
  services.tailscale.enable = true;
  services.openssh.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 25565 25566 ];

  # Users
  users.users.yourname = {
    isNormalUser = true;
    extraGroups = [ "wheel" "minecraft" ];
  };

  # Minimal system packages
  environment.systemPackages = with pkgs; [
    git vim tailscale mbpfan
    (writeShellScriptBin "start-paper" "systemctl start minecraft-server-paper")
    (writeShellScriptBin "stop-paper" "systemctl stop minecraft-server-paper")
    (writeShellScriptBin "start-fabric" "systemctl start minecraft-server-fabric")
    (writeShellScriptBin "stop-fabric" "systemctl stop minecraft-server-fabric")
  ];

  # Headless optimization
  services.xserver.enable = false;
  sound.enable = false;
  boot.initrd.verbose = false;

  # Minecraft servers
  services.minecraft-servers.enable = true;
  services.minecraft-servers.servers = {
    paper = import ./minecraft/paper.nix { inherit pkgs; };
    fabric = import ./minecraft/fabric.nix { inherit pkgs; };
  };

  system.stateVersion = "24.05";
}