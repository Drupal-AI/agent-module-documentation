#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush en cms_content_sync_simple_sitemap -y >/dev/null 2>&1
echo "cleanup: cms_content_sync_simple_sitemap enabled (baseline)"
