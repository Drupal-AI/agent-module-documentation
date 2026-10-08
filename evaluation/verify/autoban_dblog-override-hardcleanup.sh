#!/usr/bin/env bash
# Execution CLEANUP (autoban_dblog): disable autoban_dblog to restore baseline.
# AutobanDbLogController — verify FAILS until the agent enables the submodule. Idempotent.
# Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu autoban_dblog -y >/dev/null 2>&1 || true
drush cr >/dev/null 2>&1 || true
echo "cleanup: autoban_dblog disabled"
