#!/usr/bin/env bash
# Execution CLEANUP: remove the routecond_task block. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\block\Entity\Block; if ($b = Block::load("routecond_task")) { $b->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: block routecond_task removed"
