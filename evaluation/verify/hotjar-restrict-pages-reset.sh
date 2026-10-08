#!/usr/bin/env bash
# Execution RESET: set Hotjar to "all pages except listed" with the default pages list, so the
# verify (which requires only-listed /landing) FAILS until the agent changes it.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("hotjar.settings")->set("visibility_pages",0)->set("pages","/admin\n/admin/*\n/batch\n/node/add*\n/node/*/*\n/user/*/*")->save();' >/dev/null 2>&1
echo "reset: hotjar.settings visibility_pages=0, default pages"
