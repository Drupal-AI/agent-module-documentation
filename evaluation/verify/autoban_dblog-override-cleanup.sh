#!/usr/bin/env bash
# Introspection CLEANUP (autoban_dblog): disable autoban_dblog to restore the baseline
# dblog.overview controller. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu autoban_dblog -y >/dev/null 2>&1 || true
drush cr >/dev/null 2>&1 || true
echo "cleanup: autoban_dblog disabled (dblog.overview restored)"
