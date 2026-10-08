#!/usr/bin/env bash
# Execution RESET for "set tab style to High contrast": force tab_style to 'default' so the
# verify FAILS until the agent switches it to 'contrast'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("gin_moderation_sidebar.settings")->set("tab_style", "default")->save();' >/dev/null 2>&1
echo "reset: gin_moderation_sidebar.settings tab_style=default"
