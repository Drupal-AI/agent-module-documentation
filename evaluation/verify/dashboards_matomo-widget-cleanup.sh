#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($d=\Drupal::entityTypeManager()->getStorage("dashboard")->load("dm_probe")) $d->delete();' >/dev/null 2>&1
echo "cleanup: dashboard dm_probe removed"
