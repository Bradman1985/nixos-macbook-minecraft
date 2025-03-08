{ pkgs }:
{
  enable = true;
  package = pkgs.nix-minecraft.paper-server; # Latest Paper
  jvmPackage = pkgs.openjdk17;
  jvmMaxAllocation = "4G";
  jvmInitialAllocation = "2G";
  jvmOpts = [
    "-XX:+UseG1GC" "-XX:+ParallelRefProcEnabled" "-XX:MaxGCPauseMillis=200"
    "-XX:+UnlockExperimentalVMOptions" "-XX:+DisableExplicitGC"
    "-XX:G1NewSizePercent=30" "-XX:G1MaxNewSizePercent=40"
    "-XX:G1HeapRegionSize=8M" "-XX:G1ReservePercent=20"
  ];
  dataDir = "/home/yourname/minecraft/paper";
  serverProperties = {
    server-port = 25565;
    online-mode = true;
  };
  plugins = with pkgs.nix-minecraft; [
    geyser floodgate viaversion
  ];
}