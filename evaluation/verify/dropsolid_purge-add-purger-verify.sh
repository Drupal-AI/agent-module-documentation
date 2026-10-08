#!/usr/bin/env bash
# Execution VERIFY: PASS when purge.plugins -> purgers contains an entry with plugin_id
# 'dropsolid_purge'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $purgers = \Drupal::config("purge.plugins")->get("purgers") ?: [];
  $ids = array_map(fn($p) => $p["plugin_id"] ?? "?", $purgers);
  $ok = in_array("dropsolid_purge", $ids, TRUE);
  print ($ok ? "PASS" : "FAIL") . " purgers=[" . implode(",", $ids) . "]\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
