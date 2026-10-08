#!/usr/bin/env bash
# HARD reset: force the Print network OFF and clear its JS action so verify FAILS.
# The agent must enable print with api_event=onclick and api_url=window.print().
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("social_media.settings");
  $m = $c->get("social_media");
  $m["print"]["enable"] = 0;
  $m["print"]["api_url"] = "";
  $m["print"]["api_event"] = "href";
  $c->set("social_media", $m)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: social_media.settings print disabled, api_url cleared, api_event=href"
