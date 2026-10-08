#!/usr/bin/env bash
# Introspection SETUP: keep workflow buttons at the bottom only (top_buttons off).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("workflow_buttons.settings")->set("display.top_buttons", FALSE)->save();' >/dev/null 2>&1
echo "setup: display.top_buttons=false (bottom only)"
