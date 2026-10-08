#!/usr/bin/env bash
# Introspection SETUP: enable media_parent_entity_link "Link to parent entity" on the image
# formatter of field_media_image in the media Image DEFAULT view display, so an inspecting agent
# can read back which media field links to its parent. Surgical (only adds our third-party key).
set -uo pipefail
cd /var/www/html
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("media.image.default");
  if ($vd && ($c = $vd->getComponent("field_media_image"))) {
    $c["third_party_settings"]["media_parent_entity_link"]["link_to_parent"] = "1";
    $vd->setComponent("field_media_image", $c)->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: media.image.default field_media_image link_to_parent=1"
