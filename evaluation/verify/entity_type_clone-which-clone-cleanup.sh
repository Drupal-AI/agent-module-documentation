#!/usr/bin/env bash
# Introspection CLEANUP: delete the three etc_known_* content types and the two shared field
# storages. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  foreach (["etc_known_src", "etc_known_a", "etc_known_b"] as $id) {
    foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["type" => $id]) as $n) { $n->delete(); }
    if ($t = NodeType::load($id)) { $t->delete(); }
  }
  foreach (["field_etc_known", "field_etc_extra"] as $fn) {
    if ($fs = FieldStorageConfig::loadByName("node", $fn)) { $fs->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: etc_known_* content types and field storages removed"
