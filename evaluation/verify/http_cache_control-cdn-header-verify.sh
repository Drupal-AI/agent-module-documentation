#!/usr/bin/env bash
# Verify a targeted CDN-Cache-Control header is configured: an item in
# cache.targeted.items with target CDN, visibility public, max_age 86400.
# Prints PASS/FAIL and exits 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $items = \Drupal::config("http_cache_control.settings")->get("cache.targeted.items") ?: [];
  $ok = FALSE;
  foreach ($items as $it) {
    $t = trim((string)($it["target"] ?? ""));
    $t = preg_replace("/-Cache-Control$/i", "", $t);
    if (strcasecmp($t, "CDN") === 0
        && (int)($it["max_age"] ?? 0) === 86400
        && (string)($it["visibility"] ?? "") === "public") { $ok = TRUE; }
  }
  print "\n" . ($ok ? "PASS" : "FAIL") . " items=" . count($items) . "\n";
' 2>/dev/null)
echo "$out" | grep -E '^(PASS|FAIL)'
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
