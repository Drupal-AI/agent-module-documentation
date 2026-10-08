#!/usr/bin/env bash
# Execution CLEANUP: delete the State key simplei_eval_bg. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->delete("simplei_eval_bg");' >/dev/null 2>&1
echo "cleanup: State simplei_eval_bg cleared"
