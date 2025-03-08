# MacBook Server - NixOS Minecraft Setup

This repository configures a 2009 MacBook Pro as a headless NixOS server, optimized for running two Minecraft servers: a Paper server (with Bedrock support via Geyser/Floodgate) and a Fabric server (running the Create: Astral modpack). It uses Nix flakes for reproducibility, prioritizes performance over power savings, and includes Tailscale for remote access.

## Features
- **Hardware:** 2009 MacBook Pro (8GB RAM), dual-boot with macOS preserved.
- **OS:** NixOS 24.05, minimal headless setup with Linux 5.15 kernel.
- **Servers:**
  - **Paper:** Latest version, Java 17, G1GC, port 25565, with Geyser, Floodgate, and ViaVersion for Bedrock/Java crossplay.
  - **Fabric:** Create: Astral v2.1.3 (CurseForge ID 681792), Fabric 1.18.2, Java 17, G1GC, port 25566.
- **Networking:** Wi-Fi (configurable), Tailscale, SSH.
- **Optimization:** Fan control via `mbpfan`, performance-focused kernel tweaks.
- **Management:** Start/stop scripts (`start-paper`, `stop-fabric`, etc.) available system-wide.

## Prerequisites
- A 2009 MacBook Pro with NixOS installed (or ready to install).
- Git installed on the MacBook.
- Your Wi-Fi credentials and SSH public key for `secrets.nix`.
- Basic familiarity with NixOS and flakes.

## Setup Instructions

### 1. Clone the Repository
Clone this repo to your MacBook’s `/etc/nixos` directory:
```bash
git clone https://github.com/yourname/macbook-server /etc/nixos
cd /etc/nixos

2. Configure Secrets

Create a secrets.nix file in /etc/nixos/ with your Wi-Fi and SSH details (not tracked in Git):

{
  networking.wireless.networks = {
    "your-ssid" = { psk = "your-password"; };
  };
  users.users.yourname.openssh.authorizedKeys.keys = [
    "ssh-rsa your-public-key-here"
  ];
}

Replace yourname, your-ssid, your-password, and your-public-key-here with your specifics.

3. Fetch Create: Astral Hash

The Fabric server uses the Create: Astral v2.1.3 server pack from CurseForge. Get its SHA256 hash:

nix-prefetch-url https://mediafilez.forgecdn.net/files/5705/738/Create+Astral+Server+Pack+v2.1.3.zip

Update minecraft/fabric.nix with the hash (replace the placeholder in sha256 = "...").

4. Build and Apply

Build the NixOS configuration using the flake:

sudo nixos-rebuild switch --flake .#macbook-server

This generates a flake.lock locally, pinning dependencies.

5. Start the Servers

Launch the Minecraft servers with the provided scripts:

start-paper    # Paper server on port 25565
start-fabric   # Fabric server (Create: Astral) on port 25566

Stop them with:

stop-paper
stop-fabric

6. Remote Access

	•	Tailscale: Run tailscale up and authenticate to join your network. Use the Tailscale IP for SSH or VS Code remote dev.
	•	SSH: ssh yourname@<tailscale-ip> from your main machine.

File Structure

	•	flake.nix: Defines Nix inputs and system config.
	•	configuration.nix: Minimal NixOS setup with kernel, fan control, and server integration.
	•	secrets.nix: Local file for Wi-Fi and SSH keys (not in Git).
	•	minecraft/paper.nix: Paper server config with Bedrock plugins.
	•	minecraft/fabric.nix: Fabric server with Create: Astral modpack.
	•	.gitignore: Excludes secrets.nix, flake.lock, and ZIPs.

Customization

	•	Modpack: Replace the Create: Astral URL/hash in fabric.nix for a different pack.
	•	Ports: Edit serverProperties.server-port in paper.nix or fabric.nix.
	•	JVM Args: Tweak jvmOpts in server configs for performance tuning.
	•	Fan Settings: Adjust services.mbpfan.settings in configuration.nix for your MacBook’s fan profile.

Notes

	•	Wi-Fi: Performance may lag on Wi-Fi; Ethernet is recommended for multiplayer stability.
	•	Java: Paper uses OpenJDK 17, Fabric uses 17 (Create: Astral is 1.18.2-compatible).
	•	Updates: Run nix flake update to refresh dependencies, then rebuild.

Troubleshooting

	•	Server Won’t Start: Check logs with journalctl -u minecraft-server-paper or -fabric.
	•	Wi-Fi Issues: Verify secrets.nix syntax and credentials.
	•	Performance: If laggy, reduce jvmMaxAllocation (e.g., to 3G) or disable one server.

License

MIT License—feel free to adapt and share!


---

### Why It Looks Broken Here
In this chat, the nested code blocks (e.g., Bash and Nix snippets) might make it *appear* discontinuous when rendered, but the Markdown itself is a single, cohesive document. When you paste this into GitHub’s README editor, it’ll render as one flowing page—headings, paragraphs, and code blocks all in order.

### How to Use
1. Copy the entire block above (from `# MacBook Server` to `MIT License`).
2. Paste it into your GitHub repo’s README editor.
3. Replace `yourname` with your GitHub username.
4. Save/commit, and check the rendered view on GitHub.
