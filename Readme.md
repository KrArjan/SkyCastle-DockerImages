# 🛠️ Minecraft Entrypoint Scripts (JDK 8, 11, 17, 21)

This repository provides minimal, fast, and customizable `entrypoint.sh` scripts for Docker-based Minecraft server containers using **JDK 8**, **JDK 11**, **JDK 17**, and **JDK 21**.

🚀 Designed for [Pterodactyl Panel](https://pterodactyl.io), these scripts detect Minecraft versions, install necessary legacy plugins, and keep everything simple—no bloated features, no plugin selectors (except JDK 21), just clean automation.

---

## 📦 Included

- ✅ Clean version detection (from `server.jar`)
- ✅ Legacy plugin auto-install
- ✅ Lightweight and fast
- ✅ Separate versions for:
  - `entrypoint-jdk8.sh`
  - `entrypoint-jdk11.sh`
  - `entrypoint-jdk17.sh`
  - `entrypoint-jdk21.sh` → Made for **SkyCastle** by **KrArjan**

---

## ⚙️ Features

| Feature                        | JDK 8/11/17 | JDK 21 |
|-------------------------------|-------------|--------|
| Auto Plugin Install (Legacy)  | ✅          | ✅     |
| Modern Plugin System          | ❌          | ✅     |
| Minecraft Version Detection   | ✅          | ✅     |
| Clean Startup                 | ✅          | ✅     |
| Restart & Fallback Handling   | ❌          | ✅     |

---

## 🧠 Version Detection

The script uses:
```bash
unzip -p server.jar version.json | grep -oP '"name"\s*:\s*"\K[^"]+'

## 🧩 Integration (Pterodactyl)
Plug the correct `entrypoint.sh` into your custom egg:

- Use `jdk8`, `jdk11`, or `jdk17` versions for simple legacy setups.
- Use `jdk21` version for SkyCastle-like advanced servers.

## 📜 License
MIT License

## 🤝 Contribute
- Found a bug? Submit an issue.
- Want to improve logic? Open a PR.
- Have plugin automation ideas? Let’s collaborate!

## 🧊 Maintained by
**KrArjan** — [@KrArjan](https://github.com/KrArjan)
🌌 JDK 21 Version specially made for **SkyCastle Project**

