#!/usr/bin/env bash
# Introspection CLEANUP: delete the dw_probe dashboard. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($d=\Drupal::entityTypeManager()->getStorage("dashboard")->load("dw_probe")) $d->delete();' >/dev/null 2>&1
echo "cleanup: dashboard dw_probe removed"
