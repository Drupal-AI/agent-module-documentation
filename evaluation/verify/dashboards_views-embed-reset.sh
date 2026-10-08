#!/usr/bin/env bash
# Execution RESET: ensure dashboard dv_task absent (verify FAILS until the view is embedded).
set -uo pipefail
cd /var/www/html
drush php:eval 'if($d=\Drupal::entityTypeManager()->getStorage("dashboard")->load("dv_task")) $d->delete();' >/dev/null 2>&1
echo "reset: dashboard dv_task absent"
