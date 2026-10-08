#!/usr/bin/env bash
# Execution RESET: ensure the target queue eqfw_task does NOT exist, so the widget's checkbox
# for it is absent and verify FAILS until the agent creates the queue. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\entityqueue\Entity\EntityQueue;
  if ($q = EntityQueue::load("eqfw_task")) { $q->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: eqfw_task absent"
