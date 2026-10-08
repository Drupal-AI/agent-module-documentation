#!/usr/bin/env bash
# Execution VERIFY: PASS when there is an acl_node grant linking the acl_task2/node_grant ACL
# to the node titled 'acl_task2_node' with grant_view = 1. Uses raw SQL. Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $db = \Drupal::database();
  $acl_id = $db->query("SELECT acl_id FROM {acl} WHERE module=:m AND name=:n", [":m"=>"acl_task2", ":n"=>"node_grant"])->fetchField();
  $nid = $db->query("SELECT nid FROM {node_field_data} WHERE title=:t", [":t"=>"acl_task2_node"])->fetchField();
  $gv = ($acl_id && $nid) ? $db->query("SELECT grant_view FROM {acl_node} WHERE acl_id=:a AND nid=:nid", [":a"=>$acl_id, ":nid"=>$nid])->fetchField() : NULL;
  $ok = ($gv !== FALSE && $gv !== NULL && (int) $gv === 1);
  print ($ok ? "PASS" : "FAIL") . " acl_id=" . var_export($acl_id, TRUE) . " nid=" . var_export($nid, TRUE) . " grant_view=" . var_export($gv, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
