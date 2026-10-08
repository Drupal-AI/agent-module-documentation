#!/usr/bin/env bash
# Execution VERIFY for "enable the col tag on sce_task2". PASS when
# filter.format.sce_task2 filters.shortcode.status === TRUE AND
# filters.shortcode.settings.col === TRUE. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $config = \Drupal::config("filter.format.sce_task2");
  $status = $config->get("filters.shortcode.status");
  $col = $config->get("filters.shortcode.settings.col");
  $ok = ($status === TRUE && $col === TRUE);
  print ($ok ? "PASS" : "FAIL") . " status=" . var_export($status, TRUE) . " col=" . var_export($col, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
