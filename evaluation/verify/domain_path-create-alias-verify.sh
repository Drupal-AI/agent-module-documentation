#!/usr/bin/env bash
# Execution VERIFY: PASS when a path_alias exists with domain_id dp_task and alias
# '/dp-task-alias'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $found = \Drupal::entityTypeManager()->getStorage("path_alias")->loadByProperties(["domain_id"=>"dp_task","alias"=>"/dp-task-alias"]);
  $ok = !empty($found);
  $n = count($found);
  print ($ok ? "PASS" : "FAIL") . " matching_aliases=" . $n . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
