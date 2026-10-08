#!/usr/bin/env bash
# Introspection CLEANUP: remove the ib_dam.settings object (baseline = no config shipped).
set -uo pipefail
cd /var/www/html
drush cdel ib_dam.settings -y >/dev/null 2>&1 || true
drush cr >/dev/null 2>&1
echo "cleanup: ib_dam.settings deleted"
