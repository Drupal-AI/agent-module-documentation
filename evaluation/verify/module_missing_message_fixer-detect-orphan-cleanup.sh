#!/usr/bin/env bash
# medium CLEANUP (module_missing_message_fixer): remove the mmmf_orphan ghost schema entry. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::keyValue("system.schema")->delete("mmmf_orphan");' >/dev/null 2>&1
echo "cleanup: ghost module mmmf_orphan removed"
