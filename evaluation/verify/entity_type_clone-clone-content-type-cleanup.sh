#!/usr/bin/env bash
# Execution CLEANUP: delete both etc_task_src and etc_task_dst content types (and their nodes)
# plus the shared field storage. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  foreach (["etc_task_src", "etc_task_dst"] as $id) {
    foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["type" => $id]) as $n) { $n->delete(); }
    if ($t = NodeType::load($id)) { $t->delete(); }
  }
  if ($fs = FieldStorageConfig::loadByName("node", "field_etc_task")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: etc_task_src / etc_task_dst and field_etc_task removed"
