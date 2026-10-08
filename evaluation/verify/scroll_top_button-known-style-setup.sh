#!/usr/bin/env bash
# Introspection SETUP: enable scroll_top_button and set button_style to 'tab'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("scroll_top_button.settings")
    ->set("enabled", "on")->set("button_style", "tab")->save();
' >/dev/null 2>&1
echo "setup: scroll_top_button.settings enabled=on button_style=tab"
