#!/usr/bin/env bash
# Introspection SETUP: create an ACL (module 'acl_probe1', name 'acl_known_list') and add the
# admin user (uid 1) to it, so an agent can look up its membership via the ACL API/tables.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $db = \Drupal::database();
  $db->delete("acl_user")->condition("acl_id", $db->select("acl","a")->fields("a",["acl_id"])->condition("module","acl_probe1"), "IN")->execute();
  $db->delete("acl")->condition("module","acl_probe1")->execute();
  $id = acl_create_acl("acl_probe1", "acl_known_list");
  acl_add_user($id, 1);
' >/dev/null 2>&1
echo "setup: ACL acl_probe1/acl_known_list created with uid 1 (admin)"
