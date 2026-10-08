#!/usr/bin/env bash
# Reset the "configure term_reference_tree widget with cascading selection on Article"
# execution task to a clean slate. Ensures a taxonomy term reference field
# node.article.field_eval_trt EXISTS (creating it if needed), and forces its default
# form-display component to a plain core widget so verify FAILS until the agent switches it to
# term_reference_tree with cascading_selection = 1. Idempotent. Rebuilds caches. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if (!\Drupal\field\Entity\FieldStorageConfig::loadByName("node", "field_eval_trt")) {
    \Drupal\field\Entity\FieldStorageConfig::create([
      "field_name" => "field_eval_trt",
      "entity_type" => "node",
      "type" => "entity_reference",
      "settings" => ["target_type" => "taxonomy_term"],
      "cardinality" => -1,
    ])->save();
  }
  if (!\Drupal\field\Entity\FieldConfig::loadByName("node", "article", "field_eval_trt")) {
    \Drupal\field\Entity\FieldConfig::create([
      "field_name" => "field_eval_trt",
      "entity_type" => "node",
      "bundle" => "article",
      "label" => "Eval cascading tree",
      "settings" => ["handler" => "default:taxonomy_term", "handler_settings" => []],
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  if (!$fd) {
    $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->create([
      "targetEntityType" => "node", "bundle" => "article", "mode" => "default", "status" => TRUE,
    ]);
  }
  $fd->setComponent("field_eval_trt", [
    "type" => "options_buttons",
    "weight" => 21,
    "settings" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_eval_trt exists, widget forced to core options_buttons"
