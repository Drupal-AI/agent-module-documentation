#!/usr/bin/env bash
# Execution CLEANUP: delete the cs_task2.module.cs_task2mod snapshot. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($e = Drupal\config_snapshot\Entity\ConfigSnapshot::load("cs_task2.module.cs_task2mod")) { $e->delete(); }
' >/dev/null 2>&1
echo "cleanup: snapshot cs_task2.module.cs_task2mod removed"
