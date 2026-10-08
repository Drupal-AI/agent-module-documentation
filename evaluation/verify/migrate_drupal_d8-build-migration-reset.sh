#!/usr/bin/env bash
# Execution RESET: ensure migrate_plus is enabled and remove any mdd8_task migration so verify FAILS
# until the agent builds it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en migrate_plus -y >/dev/null 2>&1
drush php:eval 'use Drupal\migrate_plus\Entity\Migration; if (Migration::load("mdd8_task")) { Migration::load("mdd8_task")->delete(); }' >/dev/null 2>&1
echo "reset: migrate_plus enabled; migration mdd8_task absent"
