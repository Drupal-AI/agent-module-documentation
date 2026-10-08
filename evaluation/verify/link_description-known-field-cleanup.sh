#!/usr/bin/env bash
# Introspection CLEANUP: remove the field_ld_known field + its node. Restores baseline.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["type" => "article", "title" => "LD Known Node"]) as $n) { $n->delete(); }
  if ($fc = FieldConfig::loadByName("node", "article", "field_ld_known")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_ld_known")) { $fs->delete(); }
' >/dev/null 2>&1
echo "cleanup: field_ld_known removed from node.article"
