#!/usr/bin/env bash
# Execution CLEANUP: delete the eqfw_task queue created during the task. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\entityqueue\Entity\EntityQueue;
  if ($q = EntityQueue::load("eqfw_task")) { $q->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: eqfw_task removed"
