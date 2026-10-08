#!/usr/bin/env bash
# MEDIUM cleanup: restore ajax_loader.settings to its install-default baseline
# (throbber null, position body, all flags false).
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
echo "cleanup: ajax_loader.settings restored to baseline"
