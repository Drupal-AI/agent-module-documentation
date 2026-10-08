#!/usr/bin/env bash
# Execution CLEANUP: delete the cs_task.module.cs_taskmod snapshot. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($e = Drupal\config_snapshot\Entity\ConfigSnapshot::load("cs_task.module.cs_taskmod")) { $e->delete(); }
' >/dev/null 2>&1
echo "cleanup: snapshot cs_task.module.cs_taskmod removed"
