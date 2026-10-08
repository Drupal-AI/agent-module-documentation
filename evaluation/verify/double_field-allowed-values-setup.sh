#!/usr/bin/env bash
# Introspection SETUP: create a Double Field field_df_rating on Article whose FIRST subfield is
# limited to a known allowed-values list (list: TRUE + allowed_values) and whose SECOND subfield
# is a free integer, so an agent must read field.field.node.article.field_df_rating to report
# the permitted keys. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $fs = FieldStorageConfig::loadByName("node", "field_df_rating");
  if (!$fs) {
    $fs = FieldStorageConfig::create([
      "field_name" => "field_df_rating", "entity_type" => "node", "type" => "double_field",
    ]);
  }
  $fs->setSetting("storage", [
    "first"  => ["type" => "string",  "maxlength" => 255, "precision" => 10, "scale" => 2, "datetime_type" => "datetime"],
    "second" => ["type" => "integer", "maxlength" => 255, "precision" => 10, "scale" => 2, "datetime_type" => "datetime"],
  ]);
  $fs->save();
  $fc = FieldConfig::loadByName("node", "article", "field_df_rating");
  if (!$fc) {
    $fc = FieldConfig::create([
      "field_name" => "field_df_rating", "entity_type" => "node",
      "bundle" => "article", "label" => "Reviewer Rating",
    ]);
  }
  $fc->setSettings([
    "first" => [
      "label" => "Verdict", "min" => "", "max" => "",
      "list" => TRUE,
      "allowed_values" => ["gold" => "Gold", "silver" => "Silver", "bronze" => "Bronze"],
      "required" => TRUE, "on_label" => "On", "off_label" => "Off",
    ],
    "second" => [
      "label" => "Score", "min" => 0, "max" => 10,
      "list" => FALSE, "allowed_values" => [],
      "required" => TRUE, "on_label" => "On", "off_label" => "Off",
    ],
  ])->save();
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_df_rating", ["type" => "double_field", "weight" => 71, "region" => "content"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_df_rating first.list=TRUE allowed_values gold/silver/bronze, second integer min=0 max=10"
