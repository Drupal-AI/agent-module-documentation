#!/usr/bin/env bash
# Restore baseline: cva is part of the cumulative install and stays enabled. Idempotently
# re-ensure the enabled+rebuilt state so the site is left exactly as the suite expects.
set -uo pipefail
cd /var/www/html
drush pm:install cva -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: cva left enabled (baseline)"
