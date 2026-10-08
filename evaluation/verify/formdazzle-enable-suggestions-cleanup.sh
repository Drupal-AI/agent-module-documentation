#!/usr/bin/env bash
# Execution CLEANUP: restore baseline by ensuring formdazzle is enabled at weight 10.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if (!\Drupal::moduleHandler()->moduleExists("formdazzle")) {
    \Drupal::service("module_installer")->install(["formdazzle"]);
  }
  module_set_weight("formdazzle", 10);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: formdazzle enabled at weight 10 (baseline restored)"
