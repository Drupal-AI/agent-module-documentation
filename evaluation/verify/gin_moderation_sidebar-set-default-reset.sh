#!/usr/bin/env bash
# Execution RESET for "set tab style back to Default": force tab_style to 'contrast' so the
# verify (which checks for 'default') FAILS until the agent switches it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("gin_moderation_sidebar.settings")->set("tab_style", "contrast")->save();' >/dev/null 2>&1
echo "reset: gin_moderation_sidebar.settings tab_style=contrast"
