#!/usr/bin/env bash
# Execution CLEANUP: uninstall masonry_eval_alter FIRST, then delete its directory (an enabled
# module with a missing directory fatals the kernel on terminate and silently swallows drush
# output). Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu masonry_eval_alter -y >/dev/null 2>&1 || true
rm -rf web/modules/custom/masonry_eval_alter
drush cr >/dev/null 2>&1
drush php:eval 'print "enabled=" . var_export(\Drupal::moduleHandler()->moduleExists("masonry_eval_alter"), TRUE) . "\n";' 2>/dev/null
echo "cleanup: masonry_eval_alter uninstalled and removed"
