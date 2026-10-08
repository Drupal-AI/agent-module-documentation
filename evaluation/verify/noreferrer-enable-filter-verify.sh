#!/usr/bin/env bash
# Execution VERIFY: PASS when the noreferrer filter is enabled on text format nrf_task.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("nrf_task");
  $on = FALSE;
  if ($f) {
    $filters = $f->get("filters");
    $on = !empty($filters["noreferrer"]["status"]);
  }
  print ($on ? "PASS" : "FAIL") . " nrf_task noreferrer.status=" . var_export($on, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
