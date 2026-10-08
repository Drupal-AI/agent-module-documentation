#!/usr/bin/env bash
# Introspection SETUP: create an ACL (module 'acl_probe2', figure 7) with NO users assigned,
# so an agent can determine via the ACL API that it has no members. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $db = \Drupal::database();
  $db->delete("acl_user")->condition("acl_id", $db->select("acl","a")->fields("a",["acl_id"])->condition("module","acl_probe2"), "IN")->execute();
  $db->delete("acl")->condition("module","acl_probe2")->execute();
  acl_create_acl("acl_probe2", NULL, 7);
' >/dev/null 2>&1
echo "setup: ACL acl_probe2 figure=7 created with no users"
