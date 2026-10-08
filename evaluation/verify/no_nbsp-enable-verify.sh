#!/usr/bin/env bash
# Execution VERIFY: PASS when text format no_nbsp_hard has the filter_no_nbsp filter enabled
# (status true). Prints PASS/FAIL; exit 0 / 1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("no_nbsp_hard");
  $status = NULL;
  if ($f) {
    $filters = $f->get("filters");
    $status = $filters["filter_no_nbsp"]["status"] ?? NULL;
  }
  $ok = ($status === TRUE || $status === 1);
  print ($ok ? "PASS" : "FAIL") . " format=" . ($f ? "no_nbsp_hard" : "missing") . " filter_no_nbsp.status=" . var_export($status, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
