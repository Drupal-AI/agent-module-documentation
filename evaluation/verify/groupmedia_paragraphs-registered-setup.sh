#!/usr/bin/env bash
# Introspection SETUP: ensure the groupmedia_paragraphs submodule is enabled so its media_finder
# plugins are registered and discoverable via the plugin manager. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en groupmedia_paragraphs -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: groupmedia_paragraphs enabled; its media_finder plugins are registered"
