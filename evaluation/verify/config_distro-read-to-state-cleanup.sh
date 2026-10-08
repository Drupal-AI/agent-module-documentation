#!/usr/bin/env bash
# Execution CLEANUP: delete config_distro_eval.readh and the state key. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("config_distro_eval.readh")->delete();
  \Drupal::state()->delete("config_distro_eval_read");
' >/dev/null 2>&1
echo "cleanup: config_distro_eval.readh and state key removed"
