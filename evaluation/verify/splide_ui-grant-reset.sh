#!/usr/bin/env bash
# Execution RESET: ensure role spl_ui_editor does NOT exist, so verify FAILS until the agent creates it
# and grants 'administer splide'. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\user\Entity\Role; if ($r = Role::load("spl_ui_editor")) { $r->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: role spl_ui_editor absent"
