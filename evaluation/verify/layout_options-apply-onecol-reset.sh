#!/usr/bin/env bash
# Execution RESET: clear layout_overrides so layout_onecol uses the core LayoutDefault class and
# verify FAILS until the agent makes it use the Layout Options plugin. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("layout_options.settings")->set("layout_overrides", [])->save();
  \Drupal::service("plugin.manager.core.layout")->clearCachedDefinitions();
' >/dev/null 2>&1
echo "reset: layout_overrides cleared (layout_onecol uses core LayoutDefault)"
