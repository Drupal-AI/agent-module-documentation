#!/usr/bin/env bash
# MEDIUM cleanup: remove the Email forward-mode keys, restoring baseline (plain mailto).
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("social_media.settings");
  $m = $c->get("social_media");
  unset($m["email"]["enable_forward"]);
  unset($m["email"]["show_forward"]);
  $c->set("social_media", $m)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: social_media.settings email forward-mode keys removed"
