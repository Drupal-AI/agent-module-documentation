#!/usr/bin/env bash
# Execution RESET: ensure an ACL (module 'acl_task2', name 'node_grant') exists and a node
# titled 'acl_task2_node' exists, but NO acl_node grant links them. Verify FAILS until the
# agent grants view access. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  $db = \Drupal::database();
  // Recreate the ACL fresh (drops old grants/membership too).
  foreach ($db->select("acl","a")->fields("a",["acl_id"])->condition("module","acl_task2")->execute()->fetchCol() as $id) { acl_delete_acl($id); }
  acl_create_acl("acl_task2", "node_grant");
  // Ensure the node exists (single instance).
  $nids = \Drupal::entityTypeManager()->getStorage("node")->getQuery()->accessCheck(FALSE)->condition("title","acl_task2_node")->execute();
  if (empty($nids)) {
    Node::create(["type"=>"article","title"=>"acl_task2_node","status"=>1])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: ACL acl_task2/node_grant + node acl_task2_node present, no grant linking them"
