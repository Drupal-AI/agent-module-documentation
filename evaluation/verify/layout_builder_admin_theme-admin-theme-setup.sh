#!/usr/bin/env bash
# Introspection SETUP: ensure the override is ON (lbat_enable_admin_theme=TRUE, the default) so
# the question "which theme will Layout Builder editing use" is live. The answer is the site's
# admin theme (system.theme:admin), which the agent must read from config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("layout_builder_admin_theme.config")
    ->set("lbat_enable_admin_theme", TRUE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: override ON; admin theme = $(drush config:get system.theme admin --format=string 2>/dev/null)"
