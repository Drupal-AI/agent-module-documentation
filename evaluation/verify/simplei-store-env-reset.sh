#!/usr/bin/env bash
# Execution RESET: delete the Drupal State key simplei_eval_env so verify FAILS until the agent
# uses the simplei IndicatorParser to parse 'Black/Cyan Local' and stores the environment label.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->delete("simplei_eval_env");' >/dev/null 2>&1
echo "reset: State simplei_eval_env cleared"
