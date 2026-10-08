#!/usr/bin/env bash
# Execution RESET: UNINSTALL formdazzle (and rebuild caches) so a rendered core form carries
# only Drupal's generic theme suggestions - verify FAILS until the agent re-enables formdazzle.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if (\Drupal::moduleHandler()->moduleExists("formdazzle")) {
    \Drupal::service("module_installer")->uninstall(["formdazzle"]);
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: formdazzle uninstalled"
