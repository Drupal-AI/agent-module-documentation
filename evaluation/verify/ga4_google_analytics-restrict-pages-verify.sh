#!/usr/bin/env bash
# Execution VERIFY: PASS when tracking is limited to ONLY the blog pages, i.e. ga4_access_pages
# has negate == FALSE (track only listed) AND its pages list contains "/blog". Prints PASS/FAIL.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $p = \Drupal::config("ga4_google_analytics.config")->get("ga4_access_pages") ?: [];
  $negate = $p["negate"] ?? NULL;
  $pages = $p["pages"] ?? "";
  $ok = (($negate === FALSE || $negate === 0 || $negate === "0") && strpos($pages, "/blog") !== FALSE);
  print ($ok ? "PASS" : "FAIL") . " negate=" . var_export($negate, TRUE) . " pages=" . var_export($pages, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
