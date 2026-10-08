#!/usr/bin/env bash
# Execution CLEANUP: remove our third-party key from media.image.default. Baseline.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("media.image.default");
  if ($vd && ($c = $vd->getComponent("field_media_image"))) {
    unset($c["third_party_settings"]["media_parent_entity_link"]);
    $vd->setComponent("field_media_image", $c)->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: media.image.default field_media_image link_to_parent removed"
