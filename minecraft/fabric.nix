{ pkgs }:
let
  createAstral = pkgs.fetchurl {
    url = "https://mediafilez.forgecdn.net/files/5705/738/Create+Astral+Server+Pack+v2.1.3.zip";
    sha256 = "sha256-0e6f6e5c7c7e9e5f8d5c6e7f8e5c6e7f8d5c6e7f8e5c6e7f8d5c6e7f8e5c6e7f"; # Replace with your hash
  };
in {
  enable = true;
  package = pkgs.nix-minecraft.fabric-server;
  jvmPackage = pkgs.openjdk17; # Create: Astral uses 1.18.2, Java 17
  jvmMaxAllocation = "4G";
  jvmInitialAllocation = "2G";
  jvmOpts = [
    "-XX:+UseG1GC" "-XX:+ParallelRefProcEnabled" "-XX:MaxGCPauseMillis=200"
    "-XX:+UnlockExperimentalVMOptions" "-XX:+DisableExplicitGC"
    "-XX:G1NewSizePercent=30" "-XX:G1MaxNewSizePercent=40"
    "-XX:G1HeapRegionSize=8M" "-XX:G1ReservePercent=20"
  ];
  dataDir = "/home/yourname/minecraft/fabric";
  serverProperties = {
    server-port = 25566;
    online-mode = true;
  };
  extraPreScripts = ''
    ${pkgs.unzip}/bin/unzip -o ${createAstral} -d ${config.dataDir}
  '';
}