#!/usr/bin/env bash
# Introspection SETUP for admin_audit_trail: seed a known set of audit-trail log rows so the
# agent has recent events to inspect. admin_audit_trail_insert() is CLI-guarded (returns early
# under PHP_SAPI=cli), so we write straight to the module's `admin_audit_trail` table — exactly
# the row shape that logger produces. All seeded rows carry path='eval/audit-trail' so cleanup
# can remove precisely them. Seeds: one `node`/`delete` event and two `user` events.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $t = \Drupal::time()->getRequestTime();
  $db = \Drupal::database();
  $db->delete("admin_audit_trail")->condition("path", "eval/audit-trail")->execute();
  $rows = [
    ["type"=>"node","operation"=>"delete","description"=>"article: Eval Quarterly Report","ref_numeric"=>999,"ref_char"=>"Eval Quarterly Report","uid"=>1,"ip"=>"203.0.113.5","path"=>"eval/audit-trail","created"=>$t],
    ["type"=>"user","operation"=>"insert","description"=>"Eval Tester (uid 77)","ref_numeric"=>77,"ref_char"=>"Eval Tester","uid"=>1,"ip"=>"203.0.113.5","path"=>"eval/audit-trail","created"=>$t-60],
    ["type"=>"user","operation"=>"update","description"=>"Eval Tester (uid 77)","ref_numeric"=>77,"ref_char"=>"Eval Tester","uid"=>1,"ip"=>"203.0.113.5","path"=>"eval/audit-trail","created"=>$t-30],
  ];
  foreach ($rows as $r) { $db->insert("admin_audit_trail")->fields($r)->execute(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: seeded 3 admin_audit_trail rows (1 node/delete, 2 user) at path=eval/audit-trail"
