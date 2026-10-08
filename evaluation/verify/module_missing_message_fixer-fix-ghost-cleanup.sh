#!/usr/bin/env bash
# hard CLEANUP (module_missing_message_fixer): ensure the mmmf_task ghost schema entry is removed. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::keyValue("system.schema")->delete("mmmf_task");' >/dev/null 2>&1
echo "cleanup: ghost module mmmf_task removed"
