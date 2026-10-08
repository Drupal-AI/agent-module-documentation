#!/usr/bin/env bash
# Introspection SETUP: set config_sync's update mode to 2 (Partial reset) in state, so an
# inspecting agent can read the current update mode. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush state:set config_sync.update_mode 2 --input-format=integer >/dev/null 2>&1 \
  || drush state:set config_sync.update_mode 2 >/dev/null 2>&1
echo "setup: state config_sync.update_mode = 2 (partial reset)"
