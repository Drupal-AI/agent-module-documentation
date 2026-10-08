#!/usr/bin/env bash
# Execution VERIFY: PASS when the buty_task format has bootstrap_utilities_image_filter enabled
# (status true). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("buty_task");
  $status = FALSE;
  if ($f && ($flt = $f->filters()->get("bootstrap_utilities_image_filter"))) {
    $status = (bool) $flt->status;
  }
  print ($status ? "PASS" : "FAIL") . " image_filter_status=" . var_export($status, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
