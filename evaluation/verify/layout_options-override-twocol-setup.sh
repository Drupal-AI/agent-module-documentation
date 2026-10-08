#!/usr/bin/env bash
# Introspection SETUP: override the core layout_twocol layout to use Layout Options, so an agent
# can report which core layout is currently overridden. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("layout_options.settings")
    ->set("layout_overrides", ["layout_discovery__layout_twocol" => 1])->save();
  \Drupal::service("plugin.manager.core.layout")->clearCachedDefinitions();
' >/dev/null 2>&1
echo "setup: layout_twocol overridden to the LayoutOptions plugin class"
