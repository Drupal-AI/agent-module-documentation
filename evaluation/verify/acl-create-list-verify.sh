#!/usr/bin/env bash
# Execution VERIFY: PASS when an ACL owned by module 'acl_task' with name 'task_list' exists
# AND user uid 1 is a member of it. Uses raw SQL. Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $db = \Drupal::database();
  $acl_id = $db->query("SELECT acl_id FROM {acl} WHERE module=:m AND name=:n", [":m"=>"acl_task", ":n"=>"task_list"])->fetchField();
  $has = $acl_id ? (int) $db->query("SELECT COUNT(*) FROM {acl_user} WHERE acl_id=:a AND uid=1", [":a"=>$acl_id])->fetchField() : 0;
  $ok = ($acl_id && $has > 0);
  print ($ok ? "PASS" : "FAIL") . " acl_id=" . var_export($acl_id, TRUE) . " uid1_member=" . $has . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
