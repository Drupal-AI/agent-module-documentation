#!/usr/bin/env bash
# Execution RESET: ensure dashboard dashboards_task does NOT exist (so verify FAILS until created).
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($d=\Drupal::entityTypeManager()->getStorage("dashboard")->load("dashboards_task")) $d->delete();' >/dev/null 2>&1
echo "reset: dashboard dashboards_task absent"
