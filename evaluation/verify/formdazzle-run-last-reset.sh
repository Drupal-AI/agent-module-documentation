#!/usr/bin/env bash
# Execution RESET: set formdazzle's module weight to 0 (so it no longer runs after other
# modules' hook_form_alter), and ensure it is enabled. verify FAILS until the agent restores
# the run-last weight of 10. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if (!\Drupal::moduleHandler()->moduleExists("formdazzle")) {
    \Drupal::service("module_installer")->install(["formdazzle"]);
  }
  module_set_weight("formdazzle", 0);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: formdazzle module weight set to 0"
