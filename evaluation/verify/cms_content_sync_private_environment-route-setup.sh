#!/usr/bin/env bash
# Introspection SETUP: ensure the module is enabled so its route is registered. Idempotent.
set -uo pipefail
cd /var/www/html
if ! drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx cms_content_sync_private_environment; then
  drush en cms_content_sync_private_environment -y >/dev/null 2>&1
fi
drush cr >/dev/null 2>&1
echo "setup: cms_content_sync_private_environment enabled; route cms_content_sync_private_environment.private_environment registered"
