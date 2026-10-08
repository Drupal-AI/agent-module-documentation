#!/usr/bin/env bash
# Introspection CLEANUP: delete the gcm_probe menu type. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\group_content_menu\Entity\GroupContentMenuType; if ($t = GroupContentMenuType::load("gcm_probe")) { $t->delete(); }' >/dev/null 2>&1
echo "cleanup: group_content_menu_type gcm_probe removed"
