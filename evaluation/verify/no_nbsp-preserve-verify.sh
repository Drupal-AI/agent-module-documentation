#!/usr/bin/env bash
# Execution VERIFY: PASS when no_nbsp_pp has filter_no_nbsp enabled AND preserve_placeholders
# is true. Prints PASS/FAIL; exit 0 / 1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("no_nbsp_pp");
  $fl = $f ? $f->get("filters") : [];
  $status = $fl["filter_no_nbsp"]["status"] ?? NULL;
  $pp = $fl["filter_no_nbsp"]["settings"]["preserve_placeholders"] ?? NULL;
  $ok = (($status === TRUE || $status === 1) && ($pp === TRUE || $pp === 1));
  print ($ok ? "PASS" : "FAIL") . " status=" . var_export($status, TRUE) . " preserve_placeholders=" . var_export($pp, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
