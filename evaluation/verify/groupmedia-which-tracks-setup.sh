#!/usr/bin/env bash
# Introspection SETUP: group type gm_med2 with TWO Group media relations - Document (tracking
# OFF) and Remote video (tracking ON) - so an agent must inspect plugin_config.tracking_enabled
# to say which bundle auto-tracks. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\group\Entity\GroupType;
  $gt = GroupType::load("gm_med2") ?: GroupType::create(["id" => "gm_med2", "label" => "GM Med2"]);
  $gt->save();
  $storage = \Drupal::entityTypeManager()->getStorage("group_relationship_type");
  foreach ([["document", 0], ["remote_video", 1]] as [$bundle, $track]) {
    if (!$storage->load("gm_med2-group_media-$bundle")) {
      $storage->createFromPlugin($gt, "group_media:$bundle", [
        "group_cardinality" => 0, "entity_cardinality" => 1,
        "use_creation_wizard" => FALSE, "tracking_enabled" => $track,
      ])->save();
    }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: gm_med2 group_media:document tracking=0, group_media:remote_video tracking=1"
