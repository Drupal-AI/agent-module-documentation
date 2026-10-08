#!/usr/bin/env bash
# Execution RESET: restore ng_lightbox.settings to the shipped defaults (patterns '',
# width 700, class '', skip_admin_paths TRUE, renderer drupal_modal) so verify fails until the
# agent configures the module. Idempotent. Exit 0.
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
  print "reset: patterns=" . var_export($c->get("patterns"), TRUE) . " width=" . $c->get("default_width") . "\n";
' 2>/dev/null
drush cr >/dev/null 2>&1
exit 0
