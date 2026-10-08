#!/usr/bin/env bash
# Execution RESET: ensure NO snapshot cs_task2.module.cs_task2mod exists, so verify FAILS on
# empty state until the agent builds it with both items. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($e = Drupal\config_snapshot\Entity\ConfigSnapshot::load("cs_task2.module.cs_task2mod")) { $e->delete(); }
' >/dev/null 2>&1
echo "reset: snapshot cs_task2.module.cs_task2mod cleared"
