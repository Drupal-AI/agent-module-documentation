#!/usr/bin/env bash
# Execution RESET (autoban_dblog): DISABLE autoban_dblog so dblog.overview is NOT served by
# AutobanDbLogController — verify FAILS until the agent enables the submodule. Idempotent.
# Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu autoban_dblog -y >/dev/null 2>&1 || true
drush cr >/dev/null 2>&1 || true
echo "reset: autoban_dblog disabled"
