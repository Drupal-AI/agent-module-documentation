#!/usr/bin/env bash
# Introspection CLEANUP: remove ib_dam_media.settings (baseline = no config shipped).
set -uo pipefail
cd /var/www/html
drush cdel ib_dam_media.settings -y >/dev/null 2>&1 || true
drush cr >/dev/null 2>&1
echo "cleanup: ib_dam_media.settings deleted"
