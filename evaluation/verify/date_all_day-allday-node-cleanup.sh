#!/usr/bin/env bash
# Introspection CLEANUP: delete the two probe nodes and field_dad_probe. Restores baseline.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["DAD All Day Probe", "DAD Timed Probe"] as $title) {
    foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => $title]) as $n) {
      $n->delete();
    }
  }
  if ($fc = FieldConfig::loadByName("node", "article", "field_dad_probe")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_dad_probe")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: probe nodes and field_dad_probe removed"
