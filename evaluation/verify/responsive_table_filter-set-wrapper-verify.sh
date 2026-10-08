#!/usr/bin/env bash
# Execution VERIFY: PASS when the responsive_table_filter on rtf_wrap is enabled AND its
# wrapper_element setting is 'div'. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("rtf_wrap");
  $cfg = $f ? $f->filters("filter_responsive_table")->getConfiguration() : NULL;
  $status = $cfg["status"] ?? NULL;
  $elem = $cfg["settings"]["wrapper_element"] ?? NULL;
  $ok = ($status === TRUE) && ($elem === "div");
  print ($ok ? "PASS" : "FAIL") . " status=" . var_export($status, TRUE) . " wrapper_element=" . var_export($elem, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
