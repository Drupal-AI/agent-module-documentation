#!/usr/bin/env bash
# Execution RESET: restore ng_lightbox.settings to the shipped defaults (renderer drupal_modal,
# width 700) so verify fails until the agent switches the renderer. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("ng_lightbox.settings")
    ->set("patterns", "")
    ->set("default_width", 700)
    ->set("lightbox_class", "")
    ->set("skip_admin_paths", TRUE)
    ->set("renderer", "drupal_modal")
    ->save();
  $c = \Drupal::config("ng_lightbox.settings");
  print "reset: renderer=" . $c->get("renderer") . " width=" . $c->get("default_width") . "\n";
' 2>/dev/null
drush cr >/dev/null 2>&1
exit 0
