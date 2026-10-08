#!/usr/bin/env bash
# Introspection CLEANUP: leave markdownify_path enabled (its normal state alongside markdownify).
set -uo pipefail
cd /var/www/html
drush en markdownify_path -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: markdownify_path enabled"
