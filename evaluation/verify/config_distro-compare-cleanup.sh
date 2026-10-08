#!/usr/bin/env bash
# Execution CLEANUP: delete config_distro_eval.cmph and the state key. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("config_distro_eval.cmph")->delete();
  \Drupal::state()->delete("config_distro_eval_match");
' >/dev/null 2>&1
echo "cleanup: config_distro_eval.cmph and state key removed"
