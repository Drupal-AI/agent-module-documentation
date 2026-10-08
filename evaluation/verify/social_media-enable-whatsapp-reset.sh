#!/usr/bin/env bash
# HARD reset: force WhatsApp OFF with an empty share URL so verify FAILS on empty state.
# The agent must enable WhatsApp AND set its wa.me share api_url with a token.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("social_media.settings");
  $m = $c->get("social_media");
  $m["whatsapp"]["enable"] = 0;
  $m["whatsapp"]["api_url"] = "";
  $c->set("social_media", $m)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: social_media.settings whatsapp disabled, api_url cleared"
