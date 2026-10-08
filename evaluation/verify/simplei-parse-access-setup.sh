#!/usr/bin/env bash
# Introspection SETUP: establish a clean baseline for the simplei parser introspection (remove any
# leftover simplei_eval_* State). The fact under test is how the live simplei IndicatorParser
# service colors a '@production' indicator. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'foreach(["simplei_eval_bg","simplei_eval_env"] as $k){\Drupal::state()->delete($k);}' >/dev/null 2>&1
echo "setup: simplei IndicatorParser service is live; baseline clean"
