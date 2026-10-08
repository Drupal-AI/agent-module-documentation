#!/usr/bin/env bash
# Execution RESET: make sure two entity-reference fields exist on Article and that NO CER
# preset connects them, so the verify below fails on empty state. Also removes any leftover
# verification nodes. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\cer\Entity\CorrespondingReference;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\field\Entity\FieldStorageConfig;
  foreach (["field_cer_task_left" => "CER Task Left", "field_cer_task_right" => "CER Task Right"] as $name => $label) {
    if (!FieldStorageConfig::loadByName("node", $name)) {
      FieldStorageConfig::create([
        "field_name" => $name, "entity_type" => "node", "type" => "entity_reference",
        "settings" => ["target_type" => "node"], "cardinality" => -1,
      ])->save();
    }
    if (!FieldConfig::loadByName("node", "article", $name)) {
      FieldConfig::create([
        "field_name" => $name, "entity_type" => "node", "bundle" => "article", "label" => $label,
        "settings" => ["handler" => "default:node", "handler_settings" => ["target_bundles" => ["article" => "article"]]],
      ])->save();
    }
  }
  foreach (\Drupal::entityTypeManager()->getStorage("corresponding_reference")->loadMultiple() as $p) {
    $fields = [$p->getFirstField(), $p->getSecondField()];
    if (array_intersect($fields, ["field_cer_task_left", "field_cer_task_right"])) { $p->delete(); }
  }
  $nodes = \Drupal::entityTypeManager()->getStorage("node")
    ->loadByProperties(["title" => ["CER Verify Alpha", "CER Verify Beta"]]);
  foreach ($nodes as $n) { $n->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_cer_task_left/right exist on article, no CER preset links them"
