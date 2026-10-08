#!/usr/bin/env bash
# MEDIUM setup: put a known ajax_loader.settings config on the live site so the agent
# can inspect it. Chooses the Folding cube throbber, positioned at #main-content, with
# the core AJAX message hidden. Mirrors the pathauto setup idiom.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("ajax_loader.settings")
    ->set("throbber", "throbber_folding_cube")
    ->set("throbber_position", "#main-content")
    ->set("hide_ajax_message", TRUE)
    ->set("always_fullscreen", FALSE)
    ->set("show_admin_paths", FALSE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ajax_loader throbber=throbber_folding_cube position=#main-content"
