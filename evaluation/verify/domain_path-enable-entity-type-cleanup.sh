#!/usr/bin/env bash
# Execution CLEANUP: restore entity_types to the shipped default [node]. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("domain_path.settings")->set("entity_types",["node"])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: domain_path.settings.entity_types = [node]"
