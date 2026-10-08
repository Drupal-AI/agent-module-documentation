#!/usr/bin/env bash
# Execution CLEANUP: delete any CER preset using field_cer_buddy, the field itself, and any
# leftover verification nodes. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  use Drupal\field\Entity\FieldStorageConfig;
  foreach (\Drupal::entityTypeManager()->getStorage("corresponding_reference")->loadMultiple() as $p) {
    if (in_array("field_cer_buddy", [$p->getFirstField(), $p->getSecondField()], TRUE)) { $p->delete(); }
  }
  $nodes = \Drupal::entityTypeManager()->getStorage("node")
    ->loadByProperties(["title" => ["CER Buddy One", "CER Buddy Two"]]);
  foreach ($nodes as $n) { $n->delete(); }
  if ($fc = FieldConfig::loadByName("node", "article", "field_cer_buddy")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_cer_buddy")) { $fs->delete(); }
' >/dev/null 2>&1
echo "cleanup: CER buddy preset, field_cer_buddy and verification nodes removed"
