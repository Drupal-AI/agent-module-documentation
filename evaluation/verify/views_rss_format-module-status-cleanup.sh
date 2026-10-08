#!/usr/bin/env bash
# Introspection CLEANUP: restore baseline by re-enabling views_rss_format. Idempotent.
# Exit 0.
set -uo pipefail
cd /var/www/html
drush en views_rss_format -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: views_rss_format re-enabled"
