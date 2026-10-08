#!/usr/bin/env bash
# Execution VERIFY for "enable the highlight shortcode on shortcode_task2". PASS when
# filter.format.shortcode_task2 filters.shortcode.status === TRUE AND
# filters.shortcode.settings.highlight === TRUE. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $config = \Drupal::config("filter.format.shortcode_task2");
  $status = $config->get("filters.shortcode.status");
  $highlight = $config->get("filters.shortcode.settings.highlight");
  $ok = ($status === TRUE && $highlight === TRUE);
  print ($ok ? "PASS" : "FAIL") . " status=" . var_export($status, TRUE) . " highlight=" . var_export($highlight, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
