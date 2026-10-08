#!/usr/bin/env bash
# Execution CLEANUP: remove the test node, the two namespaced content types, and the two
# namespaced field storages (field_convbnd_src / field_convbnd_dst).
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "CB Hard Two"]) as $n) { $n->delete(); }
  foreach (["convbnd2_from", "convbnd2_to"] as $id) { if ($t = NodeType::load($id)) { $t->delete(); } }
  foreach (["field_convbnd_src", "field_convbnd_dst"] as $fn) { if ($fs = FieldStorageConfig::loadByName("node", $fn)) { $fs->delete(); } }
' >/dev/null 2>&1
echo "cleanup: CB Hard Two node + convbnd2_from/convbnd2_to + field_convbnd_src/dst removed"
