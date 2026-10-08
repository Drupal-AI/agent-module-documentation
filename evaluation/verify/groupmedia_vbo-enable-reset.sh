#!/usr/bin/env bash
# Execution RESET: uninstall groupmedia_vbo so its VBO actions are NOT registered and verify
# FAILS until the agent enables the submodule. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu groupmedia_vbo -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: groupmedia_vbo uninstalled"
