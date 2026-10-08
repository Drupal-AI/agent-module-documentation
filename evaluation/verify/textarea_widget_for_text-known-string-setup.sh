#!/usr/bin/env bash
# Introspection SETUP: create plain string field field_taw_known on Article using the
# string_textarea widget on the default form display. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_taw_known")) {
    FieldStorageConfig::create(["field_name" => "field_taw_known", "entity_type" => "node", "type" => "string"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_taw_known")) {
    FieldConfig::create(["field_name" => "field_taw_known", "entity_type" => "node", "bundle" => "article", "label" => "Known Subtitle"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_taw_known", ["type" => "string_textarea", "weight" => 60, "region" => "content", "settings" => ["rows" => 5]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_taw_known uses string_textarea"
