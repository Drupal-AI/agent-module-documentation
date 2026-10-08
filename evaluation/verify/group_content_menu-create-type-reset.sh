#!/usr/bin/env bash
# Execution RESET: ensure group_content_menu_type gcm_task does NOT exist so verify FAILS until
# the agent creates it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\group_content_menu\Entity\GroupContentMenuType; if ($t = GroupContentMenuType::load("gcm_task")) { $t->delete(); }' >/dev/null 2>&1
echo "reset: group_content_menu_type gcm_task absent"
