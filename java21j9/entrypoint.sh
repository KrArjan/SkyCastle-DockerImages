#!/bin/bash

TZ=${TZ:-UTC}
export TZ

INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

cd /home/container || exit 1

printf "\033[1m\033[33mcontainer@SkyCastle~ \033[0mjava -version\n"
java -version

# Attempt to detect Minecraft version from server.jar
SERVER_JAR="${SERVER_JARFILE}"
MC_VERSION=""

if [ -f "$SERVER_JAR" ]; then
    VERSION_STRING=$(unzip -p "$SERVER_JAR" version.json 2>/dev/null | grep -oP '"name"\s*:\s*"\K[^"]+')
    if [[ -n "$VERSION_STRING" ]]; then
        MC_VERSION="$VERSION_STRING"
        echo "[INFO] Detected Minecraft version from server.jar: $MC_VERSION"
    fi
fi

if [[ -z "$MC_VERSION" ]]; then
    echo "[ERROR] Could not detect Minecraft version from server.jar (version.json missing?)"
    exit 1
fi

# Version comparison function
version_ge() {
    [ "$(printf '%s\n' "$1" "$2" | sort -V | head -n1)" = "$2" ]
}

# Plugin Configuration
PLUGIN_NAME="DO-NOT-REMOVE.jar"
PLUGINS_DIR="/home/container/plugins"
PLUGIN_PATH="$PLUGINS_DIR/$PLUGIN_NAME"

if version_ge "$MC_VERSION" "1.20.4"; then
    echo "[INFO] Version $MC_VERSION ≥ 1.20.4. Using modern plugin."
    PLUGIN_URL="https://cdn.modrinth.com/data/7KTcTCzs/versions/bMcXRaEu/FreezeHibernate-1.0.jar"
    PLUGIN_EXPECTED_HASH="8540698e2ed6711197c7860ba9bab0d037b542f9a792ec0b819a858e20fd914d"
else
    echo "[INFO] Version $MC_VERSION < 1.20.4. Using legacy plugin."
    PLUGIN_URL="https://www.spigotmc.org/resources/hibernate.4441/download?version=506703"
    PLUGIN_EXPECTED_HASH="bd4578ca16f123a80a8f0658ccb20c63db0af0b2e5f155c7cd81b31679a4eea7"
fi

mkdir -p "$PLUGINS_DIR"

# SHA256 hash of a local file
get_local_hash() {
    sha256sum "$1" | awk '{print $1}'
}

# Remove any duplicate plugin JARs with same hash
cleanup_duplicate_plugins() {
    echo "[INFO] Checking for duplicate plugin jars in $PLUGINS_DIR..."
    for file in "$PLUGINS_DIR"/*.jar; do
        [ "$file" = "$PLUGIN_PATH" ] && continue
        if [ -f "$file" ]; then
            FILE_HASH=$(get_local_hash "$file")
            if [ "$FILE_HASH" = "$PLUGIN_EXPECTED_HASH" ]; then
                echo "[CLEANUP] Removing duplicate plugin: $(basename "$file")"
                chattr -i "$file" 2>/dev/null
                rm -f "$file"
            fi
        fi
    done
}

# Download or verify plugin
if [ -f "$PLUGIN_PATH" ]; then
    LOCAL_HASH=$(get_local_hash "$PLUGIN_PATH")
    if [ "$LOCAL_HASH" != "$PLUGIN_EXPECTED_HASH" ]; then
        echo "[INFO] Plugin hash mismatch. Updating plugin..."
        chattr -i "$PLUGIN_PATH" 2>/dev/null
        rm -f "$PLUGIN_PATH"
        curl -L -o "$PLUGIN_PATH" "$PLUGIN_URL"
        chmod 444 "$PLUGIN_PATH"
        chattr +i "$PLUGIN_PATH" 2>/dev/null || echo "[WARN] Could not set immutable bit"
    else
        echo "[INFO] Plugin is up-to-date (hash match)."
    fi
else
    echo "[INFO] Plugin not found. Downloading..."
    curl -L -o "$PLUGIN_PATH" "$PLUGIN_URL"
    chmod 444 "$PLUGIN_PATH"
    chattr +i "$PLUGIN_PATH" 2>/dev/null || echo "[WARN] Could not set immutable bit"
fi

cleanup_duplicate_plugins

# Execute startup
PARSED=$(echo "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g' | eval echo "$(cat -)")
printf "\033[1m\033[33mcontainer@SkyCastle~ \033[0m%s\n" "$PARSED"
exec env ${PARSED}