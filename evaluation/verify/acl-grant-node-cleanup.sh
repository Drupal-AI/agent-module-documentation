#!/usr/bin/env bash
# Execution CLEANUP: remove the acl_task2 ACL and delete the acl_task2_node node. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  $db = \Drupal::database();
  foreach ($db->select("acl","a")->fields("a",["acl_id"])->condition("module","acl_task2")->execute()->fetchCol() as $id) { acl_delete_acl($id); }
  $nids = \Drupal::entityTypeManager()->getStorage("node")->getQuery()->accessCheck(FALSE)->condition("title","acl_task2_node")->execute();
  if (!empty($nids)) { foreach (Node::loadMultiple($nids) as $n) { $n->delete(); } }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: acl_task2 ACL + acl_task2_node node removed"
