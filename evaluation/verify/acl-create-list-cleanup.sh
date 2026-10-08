#!/usr/bin/env bash
# Execution CLEANUP: remove the acl_task ACL and membership. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $db = \Drupal::database();
  foreach ($db->select("acl","a")->fields("a",["acl_id"])->condition("module","acl_task")->execute()->fetchCol() as $id) { acl_delete_acl($id); }
' >/dev/null 2>&1
echo "cleanup: acl_task ACL removed"
