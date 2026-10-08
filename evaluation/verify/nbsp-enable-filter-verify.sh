#!/usr/bin/env bash
# Execution VERIFY: PASS when filter.format.nbsp_task has nbsp_cleaner_filter enabled (status
# TRUE). Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $f = \Drupal\filter\Entity\FilterFormat::load("nbsp_task");
  $on = FALSE;
  if ($f && $f->filters()->has("nbsp_cleaner_filter")) { $on = (bool) $f->filters("nbsp_cleaner_filter")->status; }
  print ($on ? "PASS" : "FAIL") . " nbsp_cleaner_filter=" . var_export($on, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
