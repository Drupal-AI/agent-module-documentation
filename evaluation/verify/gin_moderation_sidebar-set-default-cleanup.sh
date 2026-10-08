#!/usr/bin/env bash
# Execution CLEANUP: ensure the shipped default tab style ('default'). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("gin_moderation_sidebar.settings")->set("tab_style", "default")->save();' >/dev/null 2>&1
echo "cleanup: gin_moderation_sidebar.settings tab_style=default"
