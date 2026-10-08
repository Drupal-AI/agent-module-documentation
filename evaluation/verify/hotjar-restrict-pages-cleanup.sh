#!/usr/bin/env bash
# Execution CLEANUP: restore shipped defaults (visibility_pages 0 + default pages list).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("hotjar.settings")->set("visibility_pages",0)->set("pages","/admin\n/admin/*\n/batch\n/node/add*\n/node/*/*\n/user/*/*")->save();' >/dev/null 2>&1
echo "cleanup: hotjar.settings visibility restored to defaults"
