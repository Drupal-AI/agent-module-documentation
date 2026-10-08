#!/usr/bin/env bash
# Execution CLEANUP: ensure the publisher submodule is enabled (session baseline). Exit 0.
set -uo pipefail
cd /var/www/html
drush en entity_share_websub_hub -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: entity_share_websub_hub enabled (baseline)"
