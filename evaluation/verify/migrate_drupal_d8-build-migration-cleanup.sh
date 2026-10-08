#!/usr/bin/env bash
# Execution CLEANUP: remove the mdd8_task migration built during the case. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\migrate_plus\Entity\Migration; if (Migration::load("mdd8_task")) { Migration::load("mdd8_task")->delete(); }' >/dev/null 2>&1
echo "cleanup: migration mdd8_task removed"
