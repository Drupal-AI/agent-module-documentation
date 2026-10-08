#!/usr/bin/env bash
# Introspection SETUP: save a known, non-default ng_lightbox.settings configuration — the
# non-modal Core Dialog renderer, a 640px width and a custom dialogClass — so the agent has to
# read the live config to say what a lightboxed link will carry.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("ng_lightbox.settings")
    ->set("patterns", "/user/login")
    ->set("default_width", 640)
    ->set("lightbox_class", "eval-dialog-class")
    ->set("skip_admin_paths", TRUE)
    ->set("renderer", "drupal_dialog")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
drush php:eval '
  $c = \Drupal::config("ng_lightbox.settings");
  print "setup: patterns=" . str_replace("\n", "|", $c->get("patterns"))
    . " width=" . $c->get("default_width")
    . " skip_admin=" . var_export($c->get("skip_admin_paths"), TRUE)
    . " renderer=" . $c->get("renderer") . "\n";
' 2>/dev/null
exit 0
