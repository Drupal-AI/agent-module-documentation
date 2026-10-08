#!/usr/bin/env bash
# MEDIUM setup: put a known ajax_loader.settings config on the live site. Chooses the
# Wave throbber shown as a full-screen overlay (always_fullscreen) and also enabled on
# admin pages (show_admin_paths). The agent must read this back from live config.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("ajax_loader.settings")
    ->set("throbber", "throbber_wave")
    ->set("throbber_position", "body")
    ->set("hide_ajax_message", FALSE)
    ->set("always_fullscreen", TRUE)
    ->set("show_admin_paths", TRUE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ajax_loader throbber=throbber_wave always_fullscreen=TRUE show_admin_paths=TRUE"
