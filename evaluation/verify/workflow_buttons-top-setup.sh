#!/usr/bin/env bash
# Introspection SETUP: enable workflow buttons at top and bottom of the form.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("workflow_buttons.settings")->set("display.top_buttons", TRUE)->save();' >/dev/null 2>&1
echo "setup: workflow_buttons.settings display.top_buttons=true"
