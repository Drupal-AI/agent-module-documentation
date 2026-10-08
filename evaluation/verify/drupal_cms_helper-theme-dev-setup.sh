#!/usr/bin/env bash
# Introspection SETUP (medium): use drupal_cms_helper's `themeDevelopmentMode` config action
# to ENABLE theme development mode (Twig debug/cache), so an inspecting agent can report it.
# Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::service("plugin.manager.config_action")
    ->applyAction("themeDevelopmentMode", "system.theme", TRUE);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: theme development mode ENABLED (twig_debug on) via themeDevelopmentMode action"
