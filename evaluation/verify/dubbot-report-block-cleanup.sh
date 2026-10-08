#!/usr/bin/env bash
# Execution CLEANUP: remove the dubbot_report_task block. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($b = \Drupal\block\Entity\Block::load("dubbot_report_task")) { $b->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: block dubbot_report_task removed"
