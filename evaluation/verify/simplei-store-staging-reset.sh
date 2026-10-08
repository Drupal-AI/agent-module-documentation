#!/usr/bin/env bash
# Execution RESET: delete the Drupal State key simplei_eval_bg so verify FAILS until the agent
# uses the simplei IndicatorParser to parse '@staging' and stores its background color there.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->delete("simplei_eval_bg");' >/dev/null 2>&1
echo "reset: State simplei_eval_bg cleared"
