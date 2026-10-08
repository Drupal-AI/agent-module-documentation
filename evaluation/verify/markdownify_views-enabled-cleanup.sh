#!/usr/bin/env bash
# Introspection CLEANUP: leave markdownify_views enabled (its normal state). Idempotent.
set -uo pipefail
cd /var/www/html
drush en markdownify_views -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: markdownify_views enabled"
