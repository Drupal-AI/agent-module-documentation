#!/usr/bin/env bash
# Introspection SETUP: give node.article a KNOWN taxonomy term reference field
# (field_trt_intro) whose default form-display component uses the term_reference_tree widget
# with distinctive settings (leaves_only TRUE, cascading_selection 2, max_depth 2,
# start_minimized FALSE) so an inspecting agent can read the widget id and its settings back
# with drush. The field does not ship by default, so it is safe to create/delete. Idempotent
# (recreated each run). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if (!\Drupal\field\Entity\FieldStorageConfig::loadByName("node", "field_trt_intro")) {
    \Drupal\field\Entity\FieldStorageConfig::create([
      "field_name" => "field_trt_intro",
      "entity_type" => "node",
      "type" => "entity_reference",
      "settings" => ["target_type" => "taxonomy_term"],
      "cardinality" => -1,
    ])->save();
  }
  if (!\Drupal\field\Entity\FieldConfig::loadByName("node", "article", "field_trt_intro")) {
    \Drupal\field\Entity\FieldConfig::create([
      "field_name" => "field_trt_intro",
      "entity_type" => "node",
      "bundle" => "article",
      "label" => "Intro tree",
      "settings" => ["handler" => "default:taxonomy_term", "handler_settings" => []],
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  if (!$fd) {
    $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->create([
      "targetEntityType" => "node", "bundle" => "article", "mode" => "default", "status" => TRUE,
    ]);
  }
  $fd->setComponent("field_trt_intro", [
    "type" => "term_reference_tree",
    "weight" => 20,
    "settings" => [
      "start_minimized" => FALSE,
      "leaves_only" => TRUE,
      "select_parents" => FALSE,
      "select_all" => FALSE,
      "cascading_selection" => 2,
      "max_depth" => 2,
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_trt_intro form display uses term_reference_tree (leaves_only, cascading_selection 2, max_depth 2)"
