#!/usr/bin/env bash
# MEDIUM setup: enable the WhatsApp network (disabled by default) and give it a known
# label + share endpoint, so the agent must read live social_media.settings to answer.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("social_media.settings");
  $m = $c->get("social_media");
  $m["whatsapp"]["enable"] = 1;
  $m["whatsapp"]["text"] = "Share on WhatsApp";
  $m["whatsapp"]["api_url"] = "https://wa.me/?text=[current-page:url]";
  $m["whatsapp"]["api_event"] = "href";
  $c->set("social_media", $m)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: social_media.settings whatsapp enabled, text='Share on WhatsApp'"
