#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->delete("config_distro_filter_eval_names");' >/dev/null 2>&1
echo "cleanup: state config_distro_filter_eval_names deleted"
