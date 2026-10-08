#!/usr/bin/env bash
# Introspection SETUP: create a string field field_li_known on Article with a
# string_textfield widget that has length_indicator enabled (optimin=40, optimax=60,
# tolerance=10), so an inspecting agent can read back the field and its optimum range.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_li_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_li_known", "entity_type" => "node", "type" => "string",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_li_known")) {
    FieldConfig::create([
      "field_name" => "field_li_known", "entity_type" => "node",
      "bundle" => "article", "label" => "Known Headline",
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_li_known", [
    "type" => "string_textfield", "weight" => 50, "region" => "content",
    "third_party_settings" => ["length_indicator" => [
      "indicator" => TRUE,
      "indicator_opt" => ["optimin" => 40, "optimax" => 60, "tolerance" => 10],
    ]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_li_known (string_textfield) has length_indicator on (40/60/10)"
