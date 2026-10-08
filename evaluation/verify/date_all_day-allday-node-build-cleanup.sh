#!/usr/bin/env bash
# Execution CLEANUP: delete the built node and field_dad_build. Restores baseline.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "DAD Build All Day"]) as $n) { $n->delete(); }
  if ($fc = FieldConfig::loadByName("node", "article", "field_dad_build")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_dad_build")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: node 'DAD Build All Day' and field_dad_build removed"
