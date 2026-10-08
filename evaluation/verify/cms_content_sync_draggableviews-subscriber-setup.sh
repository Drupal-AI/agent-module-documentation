#!/usr/bin/env bash
# Introspection SETUP: ensure the draggableviews integration is enabled so its event
# subscriber service is discoverable in the container. Idempotent.
set -uo pipefail
cd /var/www/html
if ! drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx cms_content_sync_draggableviews; then
  drush en cms_content_sync_draggableviews -y >/dev/null 2>&1
fi
drush cr >/dev/null 2>&1
echo "setup: cms_content_sync_draggableviews enabled; service cms_content_sync_draggableviews.event_subscriber registered"
