#!/usr/bin/env bash
# Introspection SETUP: add three fields to Article whose widgets render different render-element
# #types — field_prepop_a (textfield), field_prepop_b (radios / options_buttons) and
# field_prepop_c (select / options_select). Only field_prepop_b uses a #type that prepopulate
# does NOT whitelist, so the agent has to inspect the live form display to answer.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_prepop_a")) {
    FieldStorageConfig::create(["field_name" => "field_prepop_a", "entity_type" => "node", "type" => "string"])->save();
  }
  foreach (["field_prepop_b", "field_prepop_c"] as $fn) {
    if (!FieldStorageConfig::loadByName("node", $fn)) {
      FieldStorageConfig::create([
        "field_name" => $fn, "entity_type" => "node", "type" => "list_string",
        "settings" => ["allowed_values" => ["red" => "Red", "green" => "Green", "blue" => "Blue"]],
      ])->save();
    }
  }
  $labels = ["field_prepop_a" => "Campaign note", "field_prepop_b" => "Campaign colour", "field_prepop_c" => "Campaign tier"];
  foreach ($labels as $fn => $label) {
    if (!FieldConfig::loadByName("node", "article", $fn)) {
      FieldConfig::create(["field_name" => $fn, "entity_type" => "node", "bundle" => "article", "label" => $label])->save();
    }
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_prepop_a", ["type" => "string_textfield", "weight" => 61, "region" => "content"]);
  $fd->setComponent("field_prepop_b", ["type" => "options_buttons", "weight" => 62, "region" => "content"]);
  $fd->setComponent("field_prepop_c", ["type" => "options_select", "weight" => 63, "region" => "content"]);
  $fd->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_prepop_a=string_textfield, field_prepop_b=options_buttons(radios), field_prepop_c=options_select"
exit 0
