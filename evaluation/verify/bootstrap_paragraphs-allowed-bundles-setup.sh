#!/usr/bin/env bash
# Introspection SETUP: attach a Paragraphs (entity_reference_revisions) field
# field_bp_eval_allowed to node.article whose handler_settings.target_bundles allow-list is
# restricted to exactly two Bootstrap Paragraphs bundles: bp_columns_three_uneven and bp_modal.
# The agent must read the live field config to discover which bundles are permitted.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_bp_eval_allowed")) {
    FieldStorageConfig::create([
      "field_name" => "field_bp_eval_allowed", "entity_type" => "node",
      "type" => "entity_reference_revisions", "cardinality" => -1,
      "settings" => ["target_type" => "paragraph"],
    ])->save();
  }
  $fc = FieldConfig::loadByName("node", "article", "field_bp_eval_allowed");
  if (!$fc) {
    $fc = FieldConfig::create([
      "field_name" => "field_bp_eval_allowed", "entity_type" => "node",
      "bundle" => "article", "label" => "BP Eval Allowed Sections",
    ]);
  }
  $fc->setSetting("handler", "default:paragraph");
  $fc->setSetting("handler_settings", [
    "target_bundles" => [
      "bp_columns_three_uneven" => "bp_columns_three_uneven",
      "bp_modal" => "bp_modal",
    ],
    "negate" => 0,
    "target_bundles_drag_drop" => [
      "bp_columns_three_uneven" => ["enabled" => TRUE, "weight" => 1],
      "bp_modal" => ["enabled" => TRUE, "weight" => 2],
    ],
  ]);
  $fc->save();
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_bp_eval_allowed", [
    "type" => "entity_reference_paragraphs", "weight" => 60, "region" => "content",
    "settings" => [
      "title" => "Section", "title_plural" => "Sections",
      "edit_mode" => "closed", "add_mode" => "dropdown",
      "form_display_mode" => "default", "default_paragraph_type" => "_none",
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_bp_eval_allowed restricted to bp_columns_three_uneven + bp_modal"
