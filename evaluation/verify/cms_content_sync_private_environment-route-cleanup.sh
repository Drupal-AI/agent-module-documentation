#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush en cms_content_sync_private_environment -y >/dev/null 2>&1
echo "cleanup: cms_content_sync_private_environment enabled (baseline)"
