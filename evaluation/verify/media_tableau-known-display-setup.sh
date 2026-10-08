#!/usr/bin/env bash
# Introspection SETUP: create a string field field_mtb_known on Article and render it with the
# media_tableau formatter (height 654px, api_version 3.6) on the default view display, so an
# inspecting agent can read the configured height back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_mtb_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_mtb_known", "entity_type" => "node", "type" => "string",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_mtb_known")) {
    FieldConfig::create([
      "field_name" => "field_mtb_known", "entity_type" => "node",
      "bundle" => "article", "label" => "Known Tableau URL",
    ])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_mtb_known", [
    "type" => "media_tableau", "label" => "hidden", "weight" => 50, "region" => "content",
    "settings" => ["api_version" => "3.6", "width" => "100%", "height" => "654px", "toolbar" => 0],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_mtb_known uses media_tableau formatter height=654px api_version=3.6"
