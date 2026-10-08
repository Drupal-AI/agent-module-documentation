#!/usr/bin/env bash
# Introspection SETUP: ensure the simple_sitemap integration is enabled so its event
# subscriber service is discoverable. Idempotent.
set -uo pipefail
cd /var/www/html
if ! drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx cms_content_sync_simple_sitemap; then
  drush en cms_content_sync_simple_sitemap -y >/dev/null 2>&1
fi
drush cr >/dev/null 2>&1
echo "setup: cms_content_sync_simple_sitemap enabled; service cms_content_sync_simple_sitemap.event_subscriber registered"
