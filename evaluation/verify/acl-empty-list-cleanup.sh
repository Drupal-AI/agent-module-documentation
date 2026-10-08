#!/usr/bin/env bash
# Introspection CLEANUP: delete the acl_probe2 ACL. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $db = \Drupal::database();
  foreach ($db->select("acl","a")->fields("a",["acl_id"])->condition("module","acl_probe2")->execute()->fetchCol() as $id) { acl_delete_acl($id); }
' >/dev/null 2>&1
echo "cleanup: acl_probe2 ACL removed"
