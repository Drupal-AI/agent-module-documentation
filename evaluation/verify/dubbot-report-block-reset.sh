#!/usr/bin/env bash
# Execution RESET: remove the dubbot_report_task block so verify FAILS until the agent places
# a DubBot Report block. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($b = \Drupal\block\Entity\Block::load("dubbot_report_task")) { $b->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: block dubbot_report_task removed"
