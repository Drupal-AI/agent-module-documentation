#!/usr/bin/env bash
# Execution RESET: make sure the masonry_eval_alter module is BOTH uninstalled and removed from
# disk, so verify FAILS on empty state. The uninstall always runs before the directory is
# deleted - an enabled module whose directory is missing fatals the kernel. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu masonry_eval_alter -y >/dev/null 2>&1 || true
rm -rf web/modules/custom/masonry_eval_alter
drush cr >/dev/null 2>&1
echo "reset: masonry_eval_alter uninstalled and removed"
