#!/usr/bin/env bash
# Execution CLEANUP: delete the nbsp_task format. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($f = \Drupal\filter\Entity\FilterFormat::load("nbsp_task")) { $f->delete(); }' >/dev/null 2>&1
echo "cleanup: filter.format.nbsp_task removed"
