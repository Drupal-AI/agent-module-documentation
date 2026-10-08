#!/usr/bin/env bash
# Introspection SETUP: ensure groupmedia_vbo is enabled so its VBO action plugins are registered
# and discoverable in the action plugin manager. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en groupmedia_vbo -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: groupmedia_vbo enabled; its VBO action plugins are registered"
