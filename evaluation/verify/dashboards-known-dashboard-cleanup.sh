#!/usr/bin/env bash
# Introspection CLEANUP: delete the dashboards_probe dashboard. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($d=\Drupal::entityTypeManager()->getStorage("dashboard")->load("dashboards_probe")) $d->delete();' >/dev/null 2>&1
echo "cleanup: dashboard dashboards_probe removed"
