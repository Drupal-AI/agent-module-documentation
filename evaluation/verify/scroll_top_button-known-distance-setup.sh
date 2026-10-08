#!/usr/bin/env bash
# Introspection SETUP: set scroll_distance=250 and button_text='Back to top'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("scroll_top_button.settings")
    ->set("enabled", "on")->set("scroll_distance", 250)->set("button_text", "Back to top")->save();
' >/dev/null 2>&1
echo "setup: scroll_top_button.settings scroll_distance=250 button_text=Back to top"
