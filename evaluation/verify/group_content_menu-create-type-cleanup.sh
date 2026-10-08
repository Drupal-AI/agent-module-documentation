#!/usr/bin/env bash
# Execution CLEANUP: delete the gcm_task menu type. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\group_content_menu\Entity\GroupContentMenuType; if ($t = GroupContentMenuType::load("gcm_task")) { $t->delete(); }' >/dev/null 2>&1
echo "cleanup: group_content_menu_type gcm_task removed"
