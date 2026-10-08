#!/usr/bin/env bash
# Introspection SETUP: ensure caches are clear so the live config_filter plugin definitions are
# accurate; the agent must find which config filter plugin declares the config_distro distro
# storage (config_distro.storage.distro) in its 'storages'. Exit 0.
set -uo pipefail
cd /var/www/html
drush cr >/dev/null 2>&1
echo "setup: inspect plugin.manager.config_filter for the plugin whose storages include config_distro.storage.distro"
