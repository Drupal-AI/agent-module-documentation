#!/usr/bin/env bash
# Execution RESET: set domain_path.settings.entity_types to just [node] so verify FAILS until
# the agent also enables taxonomy_term. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("domain_path.settings")->set("entity_types",["node"])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: domain_path.settings.entity_types = [node]"
