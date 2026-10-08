#!/usr/bin/env bash
# Introspection SETUP: create a Double Field field_df_specs on Article whose two subfields have
# distinct, known storage types (first = string with a non-default maxlength, second = numeric
# with a non-default precision/scale), so an agent can read the storage settings back from
# field.storage.node.field_df_specs. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $fs = FieldStorageConfig::loadByName("node", "field_df_specs");
  if (!$fs) {
    $fs = FieldStorageConfig::create([
      "field_name" => "field_df_specs", "entity_type" => "node", "type" => "double_field",
    ]);
  }
  $fs->setSetting("storage", [
    "first"  => ["type" => "string",  "maxlength" => 64,  "precision" => 10, "scale" => 2, "datetime_type" => "datetime"],
    "second" => ["type" => "numeric", "maxlength" => 255, "precision" => 14, "scale" => 3, "datetime_type" => "datetime"],
  ]);
  $fs->save();
  if (!FieldConfig::loadByName("node", "article", "field_df_specs")) {
    FieldConfig::create([
      "field_name" => "field_df_specs", "entity_type" => "node",
      "bundle" => "article", "label" => "Technical Specs",
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_df_specs", ["type" => "double_field", "weight" => 70, "region" => "content"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_df_specs (double_field) storage.first=string/64 storage.second=numeric precision=14 scale=3"
