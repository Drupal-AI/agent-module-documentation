#!/usr/bin/env bash
# Live-state verification for "Basic HTML responsive filter set to Column Toggle mode".
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Reads filter.format.basic_html and checks the filter_responsive_tables_filter instance is
# present, enabled (status true) AND its tablesaw_type setting == columntoggle.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  error_reporting(E_ERROR);
  $on = FALSE; $mode = FALSE; $detail = "absent";
  $f = \Drupal::config("filter.format.basic_html")->get("filters");
  if (is_array($f) && isset($f["filter_responsive_tables_filter"])) {
    $rtf = $f["filter_responsive_tables_filter"];
    $on = !empty($rtf["status"]);
    $type = $rtf["settings"]["tablesaw_type"] ?? "";
    $mode = ($type === "columntoggle");
    $detail = "status=" . var_export($rtf["status"] ?? null, TRUE) . " tablesaw_type=" . $type;
  }
  $ok = $on && $mode;
  print ($ok ? "PASS" : "FAIL") . " on=" . ($on?1:0) . " mode=" . ($mode?1:0) . " " . $detail . "\n";
' 2>/dev/null)

echo "$out" | grep -E '^(PASS|FAIL)'
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
