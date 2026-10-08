#!/usr/bin/env bash
# Introspection SETUP: create TWO JSON fields on Article and give them DIFFERENT formatters
# on the default view display - field_jf_plain uses the "json" (Plain text) formatter with
# attach_library disabled, field_jf_fancy uses the "pretty" formatter. The agent must read
# core.entity_view_display.node.article.default to tell them apart. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_jf_plain" => "Plain Payload", "field_jf_fancy" => "Fancy Payload"] as $fn => $label) {
    if (!FieldStorageConfig::loadByName("node", $fn)) {
      FieldStorageConfig::create([
        "field_name" => $fn, "entity_type" => "node", "type" => "json",
      ])->save();
    }
    if (!FieldConfig::loadByName("node", "article", $fn)) {
      FieldConfig::create([
        "field_name" => $fn, "entity_type" => "node", "bundle" => "article", "label" => $label,
      ])->save();
    }
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_jf_plain", [
    "type" => "json", "label" => "above", "weight" => 60, "region" => "content",
    "settings" => ["attach_library" => FALSE],
  ]);
  $vd->setComponent("field_jf_fancy", [
    "type" => "pretty", "label" => "above", "weight" => 61, "region" => "content",
    "settings" => [],
  ]);
  $vd->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_jf_plain -> json formatter (attach_library FALSE), field_jf_fancy -> pretty formatter"
