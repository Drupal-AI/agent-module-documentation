#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("config_distro_eval.bridgeh")->delete();
  \Drupal::state()->delete("config_distro_filter_eval_ok");
' >/dev/null 2>&1
echo "cleanup: config_distro_eval.bridgeh and state key removed"
