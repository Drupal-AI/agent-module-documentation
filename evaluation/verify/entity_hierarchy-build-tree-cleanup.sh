#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["EH Parent Node", "EH Child Node"] as $title) {
    $existing = \Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => $title]);
    foreach ($existing as $n) { $n->delete(); }
  }
  if ($fc = FieldConfig::loadByName("node", "article", "field_eh_tree")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_eh_tree")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_eh_tree + EH Parent/Child nodes removed"
