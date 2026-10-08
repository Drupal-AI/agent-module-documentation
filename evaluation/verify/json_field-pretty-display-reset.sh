#!/usr/bin/env bash
# Execution RESET for "switch the JSON field's formatter to Pretty": ensure a JSON (text)
# field field_jf_out exists on Article and force its default view-display component back to
# the plain "json" formatter, so verify FAILS until the agent switches it to "pretty".
# Creates the field if missing. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_jf_out")) {
    FieldStorageConfig::create([
      "field_name" => "field_jf_out", "entity_type" => "node", "type" => "json",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_jf_out")) {
    FieldConfig::create([
      "field_name" => "field_jf_out", "entity_type" => "node",
      "bundle" => "article", "label" => "Output Payload",
    ])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_jf_out", [
    "type" => "json", "label" => "above", "weight" => 62, "region" => "content",
    "settings" => ["attach_library" => TRUE],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_jf_out present with the plain json formatter"
