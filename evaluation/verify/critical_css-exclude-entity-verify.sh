#!/usr/bin/env bash
# hard VERIFY (critical_css): PASS when entity id 7 is one of the excluded_ids lines. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $raw = (string) \Drupal::config("critical_css.settings")->get("excluded_ids");
  $ids = array_map("trim", preg_split("/\r?\n/", $raw));
  $ok = in_array("7", $ids, TRUE);
  print ($ok ? "PASS" : "FAIL") . " excluded_ids=" . json_encode($ids) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
