#!/usr/bin/env bash
# Execution CLEANUP: remove our third-party key from media.image.media_library. Baseline.
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
echo "cleanup: media.image.media_library thumbnail link_to_parent removed"
