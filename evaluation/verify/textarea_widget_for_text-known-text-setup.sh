#!/usr/bin/env bash
# Introspection SETUP: create formatted text field field_taw_fmt on Article using text_textarea.
set -uo pipefail
cd /var/www/html
drush php:eval '  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_taw_fmt")) {
    FieldStorageConfig::create(["field_name" => "field_taw_fmt", "entity_type" => "node", "type" => "text"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_taw_fmt")) {
    FieldConfig::create(["field_name" => "field_taw_fmt", "entity_type" => "node", "bundle" => "article", "label" => "Known Formatted"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_taw_fmt", ["type" => "text_textarea", "weight" => 61, "region" => "content", "settings" => ["rows" => 5]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_taw_fmt uses text_textarea"
