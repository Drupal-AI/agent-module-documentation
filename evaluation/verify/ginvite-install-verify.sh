#!/usr/bin/env bash
# Execution VERIFY: PASS when the group_invitation relation is installed on group type gi_task,
# i.e. the config entity group.relationship_type.gi_task-group_invitation exists with
# content_plugin=group_invitation. Read-only (no route rebuild). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ex=\Drupal::entityTypeManager()->getStorage("group_relationship_type")->loadByProperties(["group_type"=>"gi_task","content_plugin"=>"group_invitation"]);
  $rt = $ex ? reset($ex) : NULL;
  $ok = $rt && $rt->get("content_plugin")==="group_invitation";
  print ($ok ? "PASS" : "FAIL") . " reltype=" . ($rt ? $rt->id() : "none") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
