#!/usr/bin/env bash
# Execution RESET: ensure NO snapshot cs_task.module.cs_taskmod exists, so verify FAILS on
# empty state until the agent builds it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($e = Drupal\config_snapshot\Entity\ConfigSnapshot::load("cs_task.module.cs_taskmod")) { $e->delete(); }
' >/dev/null 2>&1
echo "reset: snapshot cs_task.module.cs_taskmod cleared"
