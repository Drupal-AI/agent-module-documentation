#!/usr/bin/env bash
# Execution RESET: delete state key config_distro_filter_eval_names so verify FAILS until the
# agent reads the distribution storage (which runs the transform pipeline the config_distro_filter
# bridge participates in) and records the config names it exposes. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->delete("config_distro_filter_eval_names");' >/dev/null 2>&1
echo "reset: state config_distro_filter_eval_names cleared"
