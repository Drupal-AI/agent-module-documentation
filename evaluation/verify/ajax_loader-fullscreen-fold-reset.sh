#!/usr/bin/env bash
# HARD reset: clear ajax_loader.settings back to install defaults so the execution case
# starts from empty state (no throbber, no fullscreen). The agent must configure it.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("ajax_loader.settings")
    ->set("throbber", NULL)
    ->set("throbber_position", "body")
    ->set("hide_ajax_message", FALSE)
    ->set("always_fullscreen", FALSE)
    ->set("show_admin_paths", FALSE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: ajax_loader.settings cleared to baseline (throbber=null)"
