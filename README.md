# nixos-macbook-minecraft
“NixOS config for 2009 MacBook Pro Minecraft server”.
# NixOS MacBook Minecraft Server

NixOS configuration for a 2009 MacBook Pro hosting Minecraft servers with `nix-minecraft`.

## Files
- `flake.nix`: Defines flake inputs and outputs.
- `configuration.nix`: Base system config (requires `hardware-configuration.nix`).
- `mcservers.nix`: Minecraft server definitions (Paper, Fabric, Forge).

## Setup
1. **Clone the Repository**:

​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​git clone https://github.com/yourusername/nixos-macbook-minecraft.git
cd nixos-macbook-minecraft
​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​
2. **Generate Hardware Config**:
- Boot NixOS, run `nixos-generate-config`, and copy `/etc/nixos/hardware-configuration.nix` into this directory.

3. **Build and Apply**:
​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​
sudo nixos-rebuild switch --flake .#macbook-server
​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​​
4. **Run a Server**:
- Start a server: `sudo systemctl start minecraft-server@<name>` (e.g., `paper-geyser`).
- Stop it: `sudo systemctl stop minecraft-server@<name>`.

## Notes
- Replace `<replace-with-actual-sha256>` in `mcservers.nix` with real SHA256 hashes (use `nix-prefetch-url <url>`).
- Adjust `boot.loader.grub.device` in `configuration.nix` if your disk isn’t `/dev/sda`.
- Uses `nixos-hardware` for MacBook-specific tweaks (e.g., Wi-Fi, SMC).
​​​​​​​​​​​​
