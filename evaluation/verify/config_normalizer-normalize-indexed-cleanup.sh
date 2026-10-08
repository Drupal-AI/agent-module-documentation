#!/usr/bin/env bash
# Execution CLEANUP: delete config_normalizer_eval.list and the target state key. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("config_normalizer_eval.list")->delete();
  \Drupal::state()->delete("config_normalizer_eval_list");
' >/dev/null 2>&1
echo "cleanup: config_normalizer_eval.list and state key removed"
