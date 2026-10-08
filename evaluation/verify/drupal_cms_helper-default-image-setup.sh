#!/usr/bin/env bash
# Introspection SETUP (medium): use drupal_cms_helper's `setDefaultImage` config action to
# point the media image field (media.image.field_media_image) at a KNOWN file UUID, so an
# inspecting agent can read it back. Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::service("plugin.manager.config_action")
    ->applyAction("setDefaultImage", "field.field.media.image.field_media_image", "aaaaaaaa-1111-2222-3333-444444444444");
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: default image UUID aaaaaaaa-1111-2222-3333-444444444444 set on media.image.field_media_image"
