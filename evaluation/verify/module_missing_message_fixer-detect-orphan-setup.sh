#!/usr/bin/env bash
# medium SETUP (module_missing_message_fixer): insert a ghost schema entry mmmf_orphan into
# key_value collection system.schema (a module with no code on disk). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::keyValue("system.schema")->set("mmmf_orphan", 8002);' >/dev/null 2>&1
echo "setup: ghost module mmmf_orphan added to key_value system.schema"
