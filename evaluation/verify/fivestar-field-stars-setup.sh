#!/usr/bin/env bash
# Introspection SETUP: create a fivestar field field_fs_known on Article configured to show
# 7 stars, so an inspecting agent can read the star count back from field config. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_fs_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_fs_known", "entity_type" => "node",
      "type" => "fivestar", "settings" => ["vote_type" => "vote"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_fs_known")) {
    FieldConfig::create([
      "field_name" => "field_fs_known", "entity_type" => "node", "bundle" => "article",
      "label" => "Known Rating", "settings" => ["stars" => 7, "rated_while" => "viewing"],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_fs_known (fivestar) configured with stars=7"
