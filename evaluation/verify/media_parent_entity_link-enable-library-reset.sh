#!/usr/bin/env bash
# Execution RESET: ensure the setting is OFF on media.image.media_library thumbnail, so verify
# FAILS until the agent enables it. Surgical.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("media.image.media_library");
  if ($vd && ($c = $vd->getComponent("thumbnail"))) {
    unset($c["third_party_settings"]["media_parent_entity_link"]);
    $vd->setComponent("thumbnail", $c)->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: media.image.media_library thumbnail link_to_parent OFF"
