#!/usr/bin/env bash
# Introspection SETUP: cms_content_sync_views ships system.action.export_status_entity (label
# "Force Push") on install; ensure the module is enabled so that config is present. Idempotent.
set -uo pipefail
cd /var/www/html
if ! drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx cms_content_sync_views; then
  drush en cms_content_sync_views -y >/dev/null 2>&1
fi
drush cr >/dev/null 2>&1
echo "setup: cms_content_sync_views enabled; system.action.export_status_entity label='Force Push'"
