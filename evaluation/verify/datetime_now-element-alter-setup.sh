#!/usr/bin/env bash
# Introspection SETUP: ensure a Date/time field field_dtn_elem exists on Article using the
# datetime_default widget, giving the agent a concrete widget whose Now button it must trace
# back to the responsible module by inspecting the live 'datetime' element info. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_dtn_elem")) {
    FieldStorageConfig::create([
      "field_name" => "field_dtn_elem", "entity_type" => "node",
      "type" => "datetime", "settings" => ["datetime_type" => "datetime"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_dtn_elem")) {
    FieldConfig::create([
      "field_name" => "field_dtn_elem", "entity_type" => "node",
      "bundle" => "article", "label" => "Element Probe",
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_dtn_elem", ["type" => "datetime_default", "weight" => 91, "region" => "content"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_dtn_elem (datetime_default) present; datetime element altered by datetime_now"
