#!/usr/bin/env bash
# Reset the "configure autocomplete_deluxe widget (free tagging) on Article" execution task
# to a clean slate. Ensures a taxonomy term reference field node.article.field_eval_ac EXISTS
# (creating it if needed — the task is about the *widget*, not the field), and forces its
# default form-display component back to a plain core widget so verify FAILS until the agent
# switches it to autocomplete_deluxe. Idempotent. Rebuilds caches. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if (!\Drupal\field\Entity\FieldStorageConfig::loadByName("node", "field_eval_ac")) {
    \Drupal\field\Entity\FieldStorageConfig::create([
      "field_name" => "field_eval_ac",
      "entity_type" => "node",
      "type" => "entity_reference",
      "settings" => ["target_type" => "taxonomy_term"],
      "cardinality" => -1,
    ])->save();
  }
  if (!\Drupal\field\Entity\FieldConfig::loadByName("node", "article", "field_eval_ac")) {
    \Drupal\field\Entity\FieldConfig::create([
      "field_name" => "field_eval_ac",
      "entity_type" => "node",
      "bundle" => "article",
      "label" => "Eval tags",
      "settings" => ["handler" => "default:taxonomy_term", "handler_settings" => []],
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  if (!$fd) {
    $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->create([
      "targetEntityType" => "node", "bundle" => "article", "mode" => "default", "status" => TRUE,
    ]);
  }
  // Force a non-deluxe core widget so the task starts from a failing state.
  $fd->setComponent("field_eval_ac", [
    "type" => "entity_reference_autocomplete_tags",
    "weight" => 20,
    "settings" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_eval_ac exists, widget forced to core entity_reference_autocomplete_tags"
