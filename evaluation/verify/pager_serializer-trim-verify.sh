#!/usr/bin/env bash
# Execution VERIFY: PASS when total_pages is disabled AND items_per_page_label === 'per_page'.
# Prints PASS/FAIL; exit 0 / 1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("pager_serializer.settings");
  $tp = $c->get("total_pages_enabled");
  $ipl = (string) $c->get("items_per_page_label");
  $ok = (!$tp && $ipl === "per_page");
  print ($ok ? "PASS" : "FAIL") . " total_pages_enabled=" . var_export($tp, TRUE) . " items_per_page_label=" . var_export($ipl, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
