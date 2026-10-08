#!/usr/bin/env bash
# Introspection SETUP: enable a Layout Options override for the core layout_onecol layout so
# its plugin class becomes LayoutOptions; an agent inspecting the layout plugin manager can
# report that class. Requires layout_options_ui (the alter hook). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("layout_options.settings")
    ->set("layout_overrides", ["layout_discovery__layout_onecol" => 1])->save();
  \Drupal::service("plugin.manager.core.layout")->clearCachedDefinitions();
' >/dev/null 2>&1
echo "setup: layout_onecol overridden to the LayoutOptions plugin class"
