---
title: "Deploying Clawdbot on a Mac Mini Using Cloudflare Tunnel: A Step-by-Step Guide"
pubDatetime: 2026-01-26T00:00:00Z
description: "A detailed guide to securely deploying Clawdbot on a Mac Mini and exposing it via Cloudflare Tunnel for home use"
tags: ["clawdbot", "cloudflare", "tunnel", "deployment", "security", "macos", "mac-mini", "ai", "telegram"]
draft: true
---


Learn how to deploy Clawdbot, an open-source AI assistant with full system access, on your Mac Mini and expose it securely using Cloudflare Tunnel. This step-by-step guide covers setup, installation, configuration, and best practices for a reliable home deployment.

<!-- more -->

## Introduction

![Clawdbot - The AI that actually does things](/assets/img/2026/deploying-clawdbot-cloudflare-tunnel/clawdbot-hero.png)


Clawdbot is an open-source AI assistant that provides full system access, connects to your favourite applications, and acts as a personal bot accessible via messaging platforms like Telegram. It can run locally on your Mac Mini, making it ideal for home setups where you want control without relying on cloud servers. However, given its extensive permissions, secure deployment is essential to avoid vulnerabilities.

This guide details a step-by-step process for deploying Clawdbot on a Mac Mini running macOS (tested on Sonoma 14.0 or later) and exposing it securely via Cloudflare Tunnel. This allows access from anywhere without opening ports on your home router or exposing your IP. We'll cover advantages, security importance, and all key details. Commands assume you're using the Terminal app on your Mac.

**Note**: Running on a home Mac Mini means your setup depends on your local network and power stability. Ensure your Mac is always on (e.g., disable sleep in System Settings > Battery or Energy Saver) for reliable access.

## Advantages of Using Cloudflare Tunnel with Clawdbot

Cloudflare Tunnel securely connects your local services to the internet without port forwarding or public IPs. Benefits include:

- **Enhanced Security**: Routes traffic through Cloudflare's network with DDoS protection, encryption, and access controls—perfect for home networks vulnerable to ISP changes or scans.
- **Performance Optimisation**: Uses Argo Smart Routing for faster connections, even on dynamic home IPs.
- **Ease of Use**: No router configuration needed; free tier works for personal use.
- **Cost-Effective**: Avoids VPS costs; leverages your existing Mac Mini hardware.
- **Flexibility**: Supports custom domains and quick tunnels, ideal for exposing Clawdbot's gateway without direct exposure.

Compared to alternatives like Ngrok or manual port forwarding, Cloudflare Tunnel offers better reliability and zero-trust security for home deployments.

![Cloudflare Tunnel architecture diagram](/assets/img/2026/deploying-clawdbot-cloudflare-tunnel/cloudflare-tunnel-diagram.png)

## The Importance of Securing Your Clawdbot Deployment

Clawdbot's full system access allows file interactions, API calls, and app integrations, making it a high-risk target if unsecured. On a home Mac Mini:

- **Unauthorised Access**: Exposed ports could allow intruders via your home network.
- **Data Breaches**: Risks to personal files, API keys, or connected services.
- **System Compromise**: Potential for malware, especially if your Mac is used for other tasks.
- **Home Network Risks**: Dynamic IPs and router vulnerabilities amplify threats.

Cloudflare Tunnel encrypts traffic, hides your origin, and enables policies like email gating. Use strong passwords, enable macOS firewall, and monitor activity. Community advice highlights tunnelling as a key self-securing method for local bots.

## Prerequisites

Ensure you have:
- A Mac Mini with macOS 14.0 (Sonoma) or later, at least 8 GB RAM, and sufficient storage (50 GB free recommended).
- Homebrew installed (install via `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"` if needed).
- A Cloudflare account (free; sign up at [cloudflare.com](https://www.cloudflare.com)).
- A domain in Cloudflare (optional for custom subdomains; quick tunnels use `.trycloudflare.com`).
- API keys for integrations (e.g., OpenAI, Telegram bot token).
- Terminal app open.

**Pro Tip**: For resource-intensive tasks, close other apps during setup to avoid memory issues.

## Step 1: Set Up Your Mac Mini

1. Open Terminal (search in Spotlight: Cmd + Space, type "Terminal").

2. Install or update Homebrew:
   ```bash
   brew update && brew upgrade
   ```

3. Enable macOS firewall for basic protection (System Settings > Network > Firewall > Turn On). Allow necessary apps if prompted.

4. Optionally, create a dedicated user for Clawdbot (for isolation): Go to System Settings > Users & Groups > Add Account > Standard user named "clawd". Log in as this user for the rest of the setup.

## Step 2: Install Clawdbot

1. Install Clawdbot using the official script (assumes Node.js; the script handles dependencies if needed):
   ```bash
   curl -fsSL https://clawd.bot/install.sh | bash
   ```
   This sets up Node.js via nvm if absent and installs Clawdbot. If you're on zsh (default on modern macOS), it should still work; reload shell with `source ~/.zshrc` if prompted.

2. Reload your shell:
   ```bash
   exec zsh  # Or bash if using bash
   ```

3. If memory is low, monitor with Activity Monitor (Cmd + Space, "Activity Monitor"). Clawdbot is lightweight but add virtual memory tweaks if needed via system settings.

## Step 3: Configure Clawdbot

1. Run the setup wizard:
   ```bash
   clawdbot setup --wizard
   ```
   Enter API keys and configure integrations (e.g., Telegram). This is interactive; follow prompts.

2. Start the Clawdbot gateway, binding to localhost:
   ```bash
   nohup clawdbot gateway --bind localhost --port 18789 > clawdbot.log 2>&1 &
   ```
   Runs in background on port 18789. View logs: `tail -f clawdbot.log`.

   **Detail**: Localhost binding prevents direct access; only the tunnel will expose it.

## Step 4: Install and Set Up Cloudflare Tunnel

1. Install cloudflared via Homebrew:
   ```bash
   brew install cloudflare/cloudflare/cloudflared
   ```

2. Verify:
   ```bash
   cloudflared --version
   ```

3. Authenticate with Cloudflare:
   ```bash
   cloudflared tunnel login
   ```
   Opens browser; log in and authorise.

4. Create a tunnel:
   ```bash
   cloudflared tunnel create clawdbot-tunnel
   ```
   Note the UUID.

![Cloudflare Tunnels dashboard](/assets/img/2026/deploying-clawdbot-cloudflare-tunnel/cloudflare-dashboard.png)

5. Configure: Create `~/.cloudflared/config.yml` (use `nano` or TextEdit):
   ```yaml
   tunnel: clawdbot-tunnel
   credentials-file: ~/.cloudflared/YOUR_TUNNEL_UUID.json

   ingress:
     - hostname: clawdbot.yourdomain.com
       service: http://localhost:18789
     - service: http_status:404
   ```
   Replace UUID and hostname.

6. If using a custom domain, add CNAME in Cloudflare DNS to the tunnel subdomain.

7. Run the tunnel:
   ```bash
   cloudflared tunnel run clawdbot-tunnel
   ```
   For persistent running (e.g., on reboot), use launchd: Create a plist file or run via `brew services start cloudflare/cloudflare/cloudflared`.

   **Quick Tunnel for Testing**: 
   ```bash
   cloudflared tunnel --url http://localhost:18789
   ```
   Gives a random URL like `https://random.trycloudflare.com`.

   **Home Network Tip**: No port forwarding needed on your router—tunnel handles outbound connections only.

## Step 5: Connect Messaging Apps and Verify

1. Connect apps like Telegram via wizard or config (get bot token from BotFather).

2. Access via tunnel URL (e.g., `https://clawdbot.yourdomain.com`). Test commands in connected apps.

3. Verify security: Direct port access should fail. Use Cloudflare dashboard for Zero Trust (e.g., require email login).

## Troubleshooting and Best Practices

- **Memory/Performance**: Use Activity Monitor; quit apps if slow.
- **Logs**: Check Clawdbot and cloudflared outputs.
- **Updates**: Run `brew update` regularly; check Clawdbot for updates.
- **Firewall**: Ensure cloudflared is allowed in macOS firewall.
- **Power Management**: Set Mac to "Never Sleep" for always-on access.
- **Backup**: Save config files and keys.
- **Scaling**: For heavy use, consider Docker on Mac (install via brew: `brew install --cask docker`).

## Conclusion

This setup deploys Clawdbot securely on your Mac Mini, accessible via Cloudflare Tunnel for home use. It maximises local control while minimising risks. Refer to official docs or forums for advanced tweaks. Enjoy your personalised AI assistant!
