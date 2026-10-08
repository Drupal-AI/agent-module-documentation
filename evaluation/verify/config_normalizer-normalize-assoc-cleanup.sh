#!/usr/bin/env bash
# Execution CLEANUP: delete the source config and target state key. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("config_normalizer_eval.data")->delete();
  \Drupal::state()->delete("config_normalizer_eval_sorted");
' >/dev/null 2>&1
echo "cleanup: config_normalizer_eval.data and state key removed"
