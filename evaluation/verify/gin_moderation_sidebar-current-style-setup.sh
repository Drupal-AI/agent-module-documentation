#!/usr/bin/env bash
# Introspection SETUP: set the Gin Moderation Sidebar tab style to a known non-default value
# ('contrast') so an inspecting agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("gin_moderation_sidebar.settings")->set("tab_style", "contrast")->save();' >/dev/null 2>&1
echo "setup: gin_moderation_sidebar.settings tab_style=contrast"
