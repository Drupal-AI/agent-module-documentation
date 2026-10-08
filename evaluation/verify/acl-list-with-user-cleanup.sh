#!/usr/bin/env bash
# Introspection CLEANUP: delete the acl_probe1 ACL and its membership. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $db = \Drupal::database();
  foreach ($db->select("acl","a")->fields("a",["acl_id"])->condition("module","acl_probe1")->execute()->fetchCol() as $id) { acl_delete_acl($id); }
' >/dev/null 2>&1
echo "cleanup: acl_probe1 ACL removed"
