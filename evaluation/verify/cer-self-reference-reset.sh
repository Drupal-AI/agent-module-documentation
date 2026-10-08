#!/usr/bin/env bash
# Execution RESET: make sure a single entity-reference field field_cer_buddy exists on Article
# and that no CER preset uses it, so the verify below fails on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  use Drupal\field\Entity\FieldStorageConfig;
  if (!FieldStorageConfig::loadByName("node", "field_cer_buddy")) {
    FieldStorageConfig::create([
      "field_name" => "field_cer_buddy", "entity_type" => "node", "type" => "entity_reference",
      "settings" => ["target_type" => "node"], "cardinality" => -1,
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_cer_buddy")) {
    FieldConfig::create([
      "field_name" => "field_cer_buddy", "entity_type" => "node", "bundle" => "article",
      "label" => "CER Buddy",
      "settings" => ["handler" => "default:node", "handler_settings" => ["target_bundles" => ["article" => "article"]]],
    ])->save();
  }
  foreach (\Drupal::entityTypeManager()->getStorage("corresponding_reference")->loadMultiple() as $p) {
    if (in_array("field_cer_buddy", [$p->getFirstField(), $p->getSecondField()], TRUE)) { $p->delete(); }
  }
  $nodes = \Drupal::entityTypeManager()->getStorage("node")
    ->loadByProperties(["title" => ["CER Buddy One", "CER Buddy Two"]]);
  foreach ($nodes as $n) { $n->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_cer_buddy exists on article, no CER preset uses it"
