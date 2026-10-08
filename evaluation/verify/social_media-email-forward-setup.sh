#!/usr/bin/env bash
# MEDIUM setup: turn on the Email item's "forward this page" mode (enable_forward) and
# its AJAX modal (show_forward), so the agent must inspect live config to report it.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("social_media.settings");
  $m = $c->get("social_media");
  $m["email"]["enable_forward"] = 1;
  $m["email"]["show_forward"] = 1;
  $c->set("social_media", $m)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: social_media.settings email enable_forward=1 show_forward=1"
