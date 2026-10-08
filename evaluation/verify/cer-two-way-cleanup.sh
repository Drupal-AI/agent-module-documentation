#!/usr/bin/env bash
# Execution CLEANUP: delete any CER preset using the task fields, the two fields themselves,
# and any leftover verification nodes. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  use Drupal\field\Entity\FieldStorageConfig;
  foreach (\Drupal::entityTypeManager()->getStorage("corresponding_reference")->loadMultiple() as $p) {
    $fields = [$p->getFirstField(), $p->getSecondField()];
    if (array_intersect($fields, ["field_cer_task_left", "field_cer_task_right"])) { $p->delete(); }
  }
  $nodes = \Drupal::entityTypeManager()->getStorage("node")
    ->loadByProperties(["title" => ["CER Verify Alpha", "CER Verify Beta"]]);
  foreach ($nodes as $n) { $n->delete(); }
  foreach (["field_cer_task_left", "field_cer_task_right"] as $name) {
    if ($fc = FieldConfig::loadByName("node", "article", $name)) { $fc->delete(); }
    if ($fs = FieldStorageConfig::loadByName("node", $name)) { $fs->delete(); }
  }
' >/dev/null 2>&1
echo "cleanup: CER task preset, fields and verification nodes removed"
