#!/usr/bin/env bash
# Execution RESET/CLEANUP: ensure vocabulary vdl_task does NOT exist (verify FAILS on empty).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("taxonomy.vocabulary.vdl_task")->delete();' >/dev/null 2>&1
echo "reset: vocabulary vdl_task absent"
