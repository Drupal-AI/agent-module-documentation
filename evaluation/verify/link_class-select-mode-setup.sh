#!/usr/bin/env bash
# Introspection SETUP: give node.article a KNOWN Link field (field_lc_pick) whose default
# form-display component uses the link_class_field_widget in SELECT mode with a distinctive
# key|label option list, so an inspecting agent can read the widget id, mode and the available
# class options back with drush. The field does not ship by default, safe to create/delete.
# Idempotent (recreated each run). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if (!\Drupal\field\Entity\FieldStorageConfig::loadByName("node", "field_lc_pick")) {
    \Drupal\field\Entity\FieldStorageConfig::create([
      "field_name" => "field_lc_pick",
      "entity_type" => "node",
      "type" => "link",
      "cardinality" => 1,
    ])->save();
  }
  if (!\Drupal\field\Entity\FieldConfig::loadByName("node", "article", "field_lc_pick")) {
    \Drupal\field\Entity\FieldConfig::create([
      "field_name" => "field_lc_pick",
      "entity_type" => "node",
      "bundle" => "article",
      "label" => "Pick link style",
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  if (!$fd) {
    $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->create([
      "targetEntityType" => "node", "bundle" => "article", "mode" => "default", "status" => TRUE,
    ]);
  }
  $fd->setComponent("field_lc_pick", [
    "type" => "link_class_field_widget",
    "weight" => 21,
    "settings" => [
      "link_class_mode" => "select_class",
      "link_class_force" => "",
      "link_class_select" => "btn btn-default|Default button\nbtn btn-primary|Primary button",
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_lc_pick form display uses link_class_field_widget (select_class, default/primary button options)"
