#!/usr/bin/env bash
# Introspection SETUP: enable "Link to parent entity" only on the media Image MEDIA_LIBRARY view
# display (thumbnail image formatter), leaving the default display untouched, so an agent must
# report which view mode has the behavior enabled. Surgical.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("media.image.media_library");
  if ($vd && ($c = $vd->getComponent("thumbnail"))) {
    $c["third_party_settings"]["media_parent_entity_link"]["link_to_parent"] = "1";
    $vd->setComponent("thumbnail", $c)->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: media.image.media_library thumbnail link_to_parent=1"
