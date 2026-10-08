#!/usr/bin/env bash
# Introspection SETUP: create group type gm_med and install the Group media relation for the
# Image media type with automatic tracking ON, so an inspecting agent can read back which
# media bundle is group content and whether tracking is enabled. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\group\Entity\GroupType;
  $gt = GroupType::load("gm_med") ?: GroupType::create(["id" => "gm_med", "label" => "GM Med"]);
  $gt->save();
  $storage = \Drupal::entityTypeManager()->getStorage("group_relationship_type");
  if (!$storage->load("gm_med-group_media-image")) {
    $storage->createFromPlugin($gt, "group_media:image", [
      "group_cardinality" => 0, "entity_cardinality" => 1,
      "use_creation_wizard" => FALSE, "tracking_enabled" => 1,
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: group type gm_med has group_media:image with tracking_enabled=1"
