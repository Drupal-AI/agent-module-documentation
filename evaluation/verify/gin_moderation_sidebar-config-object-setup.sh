#!/usr/bin/env bash
# Introspection SETUP: set the Gin Moderation Sidebar tab style to a known value ('contrast')
# so the agent can report the config object name and its current value. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("gin_moderation_sidebar.settings")->set("tab_style", "contrast")->save();' >/dev/null 2>&1
echo "setup: gin_moderation_sidebar.settings tab_style=contrast"
