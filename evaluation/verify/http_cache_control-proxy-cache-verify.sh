#!/usr/bin/env bash
# Verify shared-cache tuning: s-maxage == 86400 AND stale-while-revalidate == 30
# in http_cache_control.settings (the live config the response subscriber reads).
# Prints PASS/FAIL and exits 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("http_cache_control.settings");
  $s = (int) $c->get("cache.http.s_maxage");
  $w = (int) $c->get("cache.http.stale_while_revalidate");
  $ok = ($s === 86400 && $w === 30);
  print "\n" . ($ok ? "PASS" : "FAIL") . " s_maxage=" . $s . " stale_while_revalidate=" . $w . "\n";
' 2>/dev/null)
echo "$out" | grep -E '^(PASS|FAIL)'
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
