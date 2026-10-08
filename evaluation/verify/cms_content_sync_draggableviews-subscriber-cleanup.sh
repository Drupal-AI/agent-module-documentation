#!/usr/bin/env bash
# Introspection CLEANUP: restore baseline (module enabled). Idempotent.
set -uo pipefail
cd /var/www/html
drush en cms_content_sync_draggableviews -y >/dev/null 2>&1
echo "cleanup: cms_content_sync_draggableviews enabled (baseline)"
