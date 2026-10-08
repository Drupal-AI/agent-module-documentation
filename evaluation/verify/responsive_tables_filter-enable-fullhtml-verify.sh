#!/usr/bin/env bash
# Live-state verification for "enable the Responsive Tables filter on Full HTML".
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Reads filter.format.full_html and checks the filter_responsive_tables_filter instance
# is present AND enabled (status true).
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  error_reporting(E_ERROR);
  $on = FALSE; $detail = "absent";
  $f = \Drupal::config("filter.format.full_html")->get("filters");
  if (is_array($f) && isset($f["filter_responsive_tables_filter"])) {
    $rtf = $f["filter_responsive_tables_filter"];
    $on = !empty($rtf["status"]);
    $detail = "status=" . var_export($rtf["status"] ?? null, TRUE);
  }
  print ($on ? "PASS" : "FAIL") . " on=" . ($on?1:0) . " " . $detail . "\n";
' 2>/dev/null)

echo "$out" | grep -E '^(PASS|FAIL)'
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
