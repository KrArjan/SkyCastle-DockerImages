# ☕ Pterodactyl Docker Images with Hibernate Plugin (Multi-JDK)

A set of `Docker Image` scripts for different Java versions to auto-install the **Hibernate plugin** inside Docker-based Minecraft servers — designed specifically for **Pterodactyl** hosting environments.

> 🧱 Created for SkyCastle by **KrArjan**

---

## 🚀 Overview

These scripts help install the correct **Hibernate plugin** based on the Java version your server is using.

- One Hibernate plugin supports **only JDK 21**
- Another version supports **JDK 8, 11, and 17**

This repository provides tailored `Dcoker images` scripts that automatically install the right plugin when the container starts — **no user setup required**.

---

## 🧩 Integration (Pterodactyl)

Plug the `Docker Images` into your **Egg**:

- Use for **JDK 8, 11, 17**:  
  Installs **legacy Hibernate plugin**

- Use for **JDK 21**:  
  Installs **modern Hibernate plugin**

📁 No need to rename — each JDK image uses its own version of `entrypoint.sh` internally.

---

## ⚙️ Features

- ✅ Automatic Hibernate plugin installation
- ✅ No version guessing or jar parsing
- ✅ Lightweight and clean logic
- ✅ Supports Alpine and Debian containers

---

## 🌍 Environment

- Default timezone is set to `Asia/Kolkata`  
  You can override this using the `TZ` environment variable in your egg settings.

---

## 📜 License

MIT License — free to use, modify, and distribute.

---

## 🤝 Contribute

- Found a bug? [Submit an issue](https://github.com/KrArjan/SkyCastle-DockerImages/issues)
- Want to improve plugin logic? Open a PR
- Got ideas for auto-installing other plugins? Let’s collaborate!

---

## 🧊 Maintained by

**KrArjan** — [@KrArjan](https://github.com/KrArjan)  
🌌 JDK 21 version specially made for the **SkyCastle Project**

> 🧩 “Simplifying Hibernate integration for every Minecraft server host.”
