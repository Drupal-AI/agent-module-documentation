#!/usr/bin/env bash
# Execution CLEANUP: delete mon_task. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\monitoring\Entity\SensorConfig;
  if ($s = SensorConfig::load("mon_task")) { $s->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: sensor mon_task removed"
