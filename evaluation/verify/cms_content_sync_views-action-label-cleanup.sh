#!/usr/bin/env bash
# Introspection CLEANUP: baseline = module enabled (health depends on it). Idempotent.
set -uo pipefail
cd /var/www/html
drush en cms_content_sync_views -y >/dev/null 2>&1
echo "cleanup: cms_content_sync_views enabled (baseline)"
