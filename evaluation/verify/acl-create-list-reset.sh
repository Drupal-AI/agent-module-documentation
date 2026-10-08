#!/usr/bin/env bash
# Execution RESET: remove any ACL owned by module 'acl_task' (and its membership/grants) so the
# agent must create it. Verify FAILS on this empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $db = \Drupal::database();
  foreach ($db->select("acl","a")->fields("a",["acl_id"])->condition("module","acl_task")->execute()->fetchCol() as $id) { acl_delete_acl($id); }
' >/dev/null 2>&1
echo "reset: no ACL for module acl_task"
