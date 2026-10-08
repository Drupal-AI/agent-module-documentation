#!/usr/bin/env bash
# Introspection SETUP: save a known, non-default ng_lightbox.settings configuration (two path
# patterns, 900px dialogs, admin paths NOT skipped) so the agent has to read the live config.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("ng_lightbox.settings")
    ->set("patterns", "/contact\n/node/*")
    ->set("default_width", 900)
    ->set("lightbox_class", "")
    ->set("skip_admin_paths", FALSE)
    ->set("renderer", "drupal_modal")
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
