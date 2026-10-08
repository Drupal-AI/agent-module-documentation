#!/usr/bin/env bash
# Introspection CLEANUP: restore alias_title to the shipped default 'name'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("domain_path.settings")->set("alias_title","name")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: domain_path.settings.alias_title = name"
