#!/usr/bin/env bash
# Introspection SETUP: Article gets two list_string fields; field_ot_drag uses the
# options_table (Draggable Table) widget, field_ot_plain uses the core options_buttons
# (Check boxes/radio buttons) widget. Agent must inspect and say which one is draggable.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_ot_drag", "field_ot_plain"] as $fn) {
    if (!FieldStorageConfig::loadByName("node", $fn)) {
      FieldStorageConfig::create([
        "field_name" => $fn, "entity_type" => "node", "type" => "list_string",
        "cardinality" => -1,
        "settings" => ["allowed_values" => ["a" => "A", "b" => "B", "c" => "C"]],
      ])->save();
    }
    if (!FieldConfig::loadByName("node", "article", $fn)) {
      FieldConfig::create([
        "field_name" => $fn, "entity_type" => "node", "bundle" => "article", "label" => $fn,
      ])->save();
    }
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_ot_drag", ["type" => "options_table", "weight" => 51, "region" => "content", "settings" => [], "third_party_settings" => []])->save();
  $fd->setComponent("field_ot_plain", ["type" => "options_buttons", "weight" => 52, "region" => "content", "settings" => [], "third_party_settings" => []])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_ot_drag=options_table, field_ot_plain=options_buttons"
