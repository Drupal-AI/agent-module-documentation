#!/usr/bin/env bash
# Introspection SETUP: create a Video Embed field field_veh_known on Article restricted to the
# html_5 provider (allowed_providers=['html_5']) so an inspecting agent can read it back.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  if (!FieldStorageConfig::loadByName("node", "field_veh_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_veh_known", "entity_type" => "node", "type" => "video_embed_field",
    ])->save();
  }
' >/dev/null 2>&1
drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  if (!FieldConfig::loadByName("node", "article", "field_veh_known")) {
    FieldConfig::create([
      "field_name" => "field_veh_known", "entity_type" => "node",
      "bundle" => "article", "label" => "Known Video",
    ])->save();
  }
  $fc = FieldConfig::loadByName("node", "article", "field_veh_known");
  $fc->setSetting("allowed_providers", ["html_5"])->save();
' >/dev/null 2>&1
echo "setup: node.article field_veh_known allowed_providers=[html_5]"
