#!/usr/bin/env bash
# Introspection CLEANUP: remove the settings object (baseline = no config shipped).
set -uo pipefail
cd /var/www/html
drush cdel facet_bot_blocker.settings -y >/dev/null 2>&1 || true
drush cr >/dev/null 2>&1
echo "cleanup: facet_bot_blocker.settings deleted"
