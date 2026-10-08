#!/usr/bin/env bash
# Introspection SETUP: ensure both entity_share_websub functional submodules are enabled so
# an inspecting agent can read back which are on. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en entity_share_websub_hub entity_share_websub_subscriber -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: entity_share_websub_hub and entity_share_websub_subscriber enabled"
