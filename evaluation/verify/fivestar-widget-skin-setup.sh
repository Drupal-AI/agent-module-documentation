#!/usr/bin/env bash
# Introspection SETUP: create a fivestar field field_fs_skin on Article and configure its
# default view-display formatter (fivestar_stars) to use the "hearts" star skin, so an agent
# can read the configured skin back from the entity_view_display. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_fs_skin")) {
    FieldStorageConfig::create([
      "field_name" => "field_fs_skin", "entity_type" => "node",
      "type" => "fivestar", "settings" => ["vote_type" => "vote"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_fs_skin")) {
    FieldConfig::create([
      "field_name" => "field_fs_skin", "entity_type" => "node", "bundle" => "article",
      "label" => "Skinned Rating",
    ])->save();
  }
  \Drupal::service("entity_display.repository")
    ->getViewDisplay("node", "article", "default")
    ->setComponent("field_fs_skin", [
      "type" => "fivestar_stars",
      "settings" => ["fivestar_widget" => "hearts", "display_format" => "average", "text_format" => "none"],
    ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_fs_skin fivestar_stars formatter uses fivestar_widget=hearts"
