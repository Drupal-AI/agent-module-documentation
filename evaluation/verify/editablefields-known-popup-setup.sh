#!/usr/bin/env bash
# Introspection SETUP: create a text field field_ef_note on Article and set its display
# formatter to editablefields_formatter with popup behaviour, so the agent can inspect the
# live view display to identify the editable field and its behaviour. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ef_note")) {
    FieldStorageConfig::create(["field_name"=>"field_ef_note","entity_type"=>"node","type"=>"string"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ef_note")) {
    FieldConfig::create(["field_name"=>"field_ef_note","entity_type"=>"node","bundle"=>"article","label"=>"Editable Note"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_ef_note", [
    "type" => "editablefields_formatter", "label" => "hidden", "weight" => 80, "region" => "content",
    "settings" => ["form_mode" => "default", "behaviour" => "popup"],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_ef_note editablefields_formatter behaviour=popup"
