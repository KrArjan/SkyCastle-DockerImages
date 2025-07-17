#!/bin/bash

# === Set Timezone ===
TZ=${TZ:-Asia/Kolkata}
export TZ

# === Internal Docker IP ===
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

# === Go to container directory ===
cd /home/container || exit 1

# === Print Java version ===
printf "\033[1m\033[33mcontainer@SkyCastle~ \033[0mjava -version\n"
java -version

# === Plugin Setup ===
PLUGIN_NAME="DefaultPlugin.jar"
PLUGIN_URL="https://example.com/path/to/default-plugin.jar"  # 🔁 Replace this
PLUGINS_DIR="/home/container/plugins"

echo "[INFO] Java 8 detected — installing default plugin..."
rm -f "$PLUGINS_DIR/$PLUGIN_NAME"
curl -L -o "$PLUGINS_DIR/$PLUGIN_NAME" "$PLUGIN_URL"

# === Start Server ===
PARSED=$(echo "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g' | eval echo "$(cat -)")
printf "\033[1m\033[33mcontainer@SkyCastle~ \033[0m%s\n" "$PARSED"
exec env ${PARSED}
