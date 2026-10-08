#!/usr/bin/env bash
# Introspection SETUP: ensure the node module is enabled and caches are clear, so the
# config_provider collector returns a deterministic, discoverable set of config for node.
# No persistent fixture is needed: the collected set is derived live from node's config/install
# by the config_provider.collector service, which is exactly what the agent must run. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx node || drush en node -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node enabled; run config_provider.collector for node to see provided config"
