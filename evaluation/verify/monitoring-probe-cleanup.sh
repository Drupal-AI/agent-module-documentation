#!/usr/bin/env bash
# Introspection CLEANUP: delete the mon_probe sensor config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\monitoring\Entity\SensorConfig;
  if ($s = SensorConfig::load("mon_probe")) { $s->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: sensor mon_probe removed"
