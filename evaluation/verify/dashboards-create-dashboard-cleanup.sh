#!/usr/bin/env bash
# Execution CLEANUP: delete dashboards_task. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($d=\Drupal::entityTypeManager()->getStorage("dashboard")->load("dashboards_task")) $d->delete();' >/dev/null 2>&1
echo "cleanup: dashboard dashboards_task removed"
