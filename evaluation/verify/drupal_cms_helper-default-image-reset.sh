#!/usr/bin/env bash
# Execution RESET (hard): clear any default image UUID on the media image field so verify FAILs
# on empty state. The agent must set it using drupal_cms_helper's setDefaultImage action.
# Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("field.field.media.image.field_media_image");
  $s = $c->get("settings");
  $s["default_image"]["uuid"] = NULL;
  $c->set("settings", $s)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: default image UUID cleared on media.image.field_media_image"
