#!/usr/bin/env bash
# Execution RESET: uninstall the integration so verify fails until enabled.
set -uo pipefail
cd /var/www/html
drush pmu cms_content_sync_simple_sitemap -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: cms_content_sync_simple_sitemap uninstalled"
