#!/usr/bin/env bash
# Execution VERIFY: PASS when the Typogrify filter is enabled (status true) on the
# typogrify_eval_h text format. Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("typogrify_eval_h");
  $status = FALSE;
  if ($f) {
    $filters = $f->get("filters") ?: [];
    $status = !empty($filters["typogrify"]["status"]);
  }
  print ($status ? "PASS" : "FAIL") . " typogrify_status=" . var_export($status, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
