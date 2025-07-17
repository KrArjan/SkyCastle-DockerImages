#!/bin/bash

TZ=${TZ:-Asia/Kolkata}
export TZ

INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

cd /home/container || exit 1

printf "\033[1m\033[33mcontainer@SkyCastle~ \033[0mjava -version\n"
java -version

PLUGIN_NAME="DefaultPlugin.jar"
PLUGIN_URL="https://example.com/path/to/default-plugin.jar"
PLUGINS_DIR="/home/container/plugins"

echo "[INFO] JDK17 detected — installing default plugin..."
rm -f "$PLUGINS_DIR/$PLUGIN_NAME"
curl -L -o "$PLUGINS_DIR/$PLUGIN_NAME" "$PLUGIN_URL"

PARSED=$(echo "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g' | eval echo "$(cat -)")
printf "\033[1m\033[33mcontainer@SkyCastle~ \033[0m%s\n" "$PARSED"
exec env ${PARSED}
