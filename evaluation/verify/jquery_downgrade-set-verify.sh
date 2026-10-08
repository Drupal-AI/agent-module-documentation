#!/usr/bin/env bash
# Execution VERIFY: PASS when jquery_downgrade.settings node_ids contains 88. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ids = \Drupal::config("jquery_downgrade.settings")->get("node_ids") ?? [];
  $ids = array_map("intval", (array) $ids);
  $ok = in_array(88, $ids, TRUE);
  print ($ok ? "PASS" : "FAIL") . " node_ids=" . implode(",", $ids) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
