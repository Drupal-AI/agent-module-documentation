#!/usr/bin/env bash
# Execution VERIFY: PASS when the responsive_table_filter is enabled (status TRUE) on the
# rtf_task text format. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("rtf_task");
  $cfg = $f ? $f->filters("filter_responsive_table")->getConfiguration() : NULL;
  $status = $cfg["status"] ?? NULL;
  $ok = ($status === TRUE);
  print ($ok ? "PASS" : "FAIL") . " status=" . var_export($status, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
