#!/usr/bin/env bash
# Execution RESET: ensure layout_fourcol_section is ENABLED (clear the disabled list) so verify
# FAILS until the agent disables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("layout_disable.settings");
  $c->clear("disabled_layouts")->save();
  \Drupal::service("plugin.manager.core.layout")->clearCachedDefinitions();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: no layouts disabled (layout_fourcol_section available)"
