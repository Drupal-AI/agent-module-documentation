#!/usr/bin/env bash
# MEDIUM cleanup: restore WhatsApp to its install defaults (disabled, no label).
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("social_media.settings");
  $m = $c->get("social_media");
  $m["whatsapp"]["enable"] = 0;
  unset($m["whatsapp"]["text"]);
  $m["whatsapp"]["api_url"] = "https://wa.me/?text=[current-page:url]";
  $m["whatsapp"]["api_event"] = "href";
  $c->set("social_media", $m)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: social_media.settings whatsapp restored to default (disabled)"
