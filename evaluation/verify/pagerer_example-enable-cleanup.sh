#!/usr/bin/env bash
# Restore baseline: ensure pagerer_example is enabled (it was enabled before the eval).
set -uo pipefail
cd /var/www/html
if ! drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx pagerer_example; then
  drush en pagerer_example -y >/dev/null 2>&1
fi
drush cr >/dev/null 2>&1
echo "cleanup: pagerer_example enabled"
