#!/usr/bin/env bash
# Execution CLEANUP: restore shipped default memory_limit_policy.settings:header = FALSE. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("memory_limit_policy.settings")->set("header", FALSE)->save();' >/dev/null 2>&1
echo "cleanup: memory_limit_policy.settings header restored to FALSE"
