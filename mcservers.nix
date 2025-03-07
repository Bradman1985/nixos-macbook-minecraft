{ config, pkgs, nix-minecraft, ... }:

let
  mcPkgs = pkgs.extend nix-minecraft.overlay;
in {
  services.minecraft-servers = {
    enable = true;
    eula = true;

    servers = {
      paper-geyser = {
        enable = false;
        package = mcPkgs.minecraftServers.paper-1_20_1;
        jvmOpts = "-Xms1024M -Xmx1536M";
        serverProperties = {
          port = 25565;
          motd = "Paper Server with Bedrock Support";
          difficulty = "normal";
          gamemode = "survival";
          max-players = 10;
          online-mode = false;
        };
        symlinks = {
          "plugins/Geyser-Spigot.jar" = pkgs.fetchurl {
            url = "https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/spigot";
            sha256 = "<replace-with-actual-sha256>";
          };
          "plugins/Floodgate-Spigot.jar" = pkgs.fetchurl {
            url = "https://download.geysermc.org/v2/projects/floodgate/versions/latest/builds/latest/downloads/spigot";
            sha256 = "<replace-with-actual-sha256>";
          };
        };
      };

      fabric-create-astral = {
        enable = false;
        package = mcPkgs.minecraftServers.fabric-1_19_2;
        jvmOpts = "-Xms1024M -Xmx2048M";
        serverProperties = {
          port = 25566;
          motd = "Fabric: Create and Astral Adventures";
          difficulty = "normal";
          gamemode = "survival";
          max-players = 5;
        };
        symlinks = {
          "mods/create-fabric.jar" = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/AU1Xg0oW/versions/1.19.2-0.5.1.f/create-1.19.2-0.5.1.f.jar";
            sha256 = "<replace-with-actual-sha256>";
          };
          "mods/astral-fabric.jar" = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/9uBgo9gG/versions/1.19.2-1.2.0/astral-1.19.2-1.2.0.jar";
            sha256 = "<replace-with-actual-sha256>";
          };
          "mods/fabric-api.jar" = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/0.76.0+1.19.2/fabric-api-0.76.0+1.19.2.jar";
            sha256 = "<replace-with-actual-sha256>";
          };
        };
      };

      forge-rlcraft = {
        enable = false;
        package = mcPkgs.minecraftServers.forge-1_12_2;
        jvmOpts = "-Xms1536M -Xmx2048M";
        serverProperties = {
          port = 25567;
          motd = "RLCraft: Survive the Chaos";
          difficulty = "hard";
          gamemode = "survival";
          max-players = 5;
        };
        symlinks = {
          "mods/rlcraft.jar" = pkgs.fetchurl {
            url = "https://www.curseforge.com/minecraft/modpacks/rlcraft/files/2780296/download";
            sha256 = "<replace-with-actual-sha256>";
          };
        };
      };

      forge-techreborn = {
        enable = false;
        package = mcPkgs.minecraftServers.forge-1_18_2;
        jvmOpts = "-Xms1024M -Xmx1536M";
        serverProperties = {
          port = 25568;
          motd = "Tech Reborn: Engineer Your World";
          difficulty = "normal";
          gamemode = "survival";
          max-players = 5;
        };
        symlinks = {
          "mods/techreborn.jar" = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/AHMn2SID/versions/1.18.2-5.1.0/techreborn-1.18.2-5.1.0.jar";
            sha256 = "<replace-with-actual-sha256>";
          };
          "mods/reborncore.jar" = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/zDhdVI1v/versions/5.8.0/reborncore-5.8.0.jar";
            sha256 = "<replace-with-actual-sha256>";
          };
        };
      };
    };
  };
}
​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​
