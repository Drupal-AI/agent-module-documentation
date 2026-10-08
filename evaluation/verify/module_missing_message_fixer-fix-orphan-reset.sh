#!/usr/bin/env bash
# hard RESET (module_missing_message_fixer): (re)insert the ghost schema entry mmmf_gone so verify
# FAILS until it is removed. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::keyValue("system.schema")->set("mmmf_gone", 8004);' >/dev/null 2>&1
echo "reset: ghost module mmmf_gone present in key_value system.schema"
