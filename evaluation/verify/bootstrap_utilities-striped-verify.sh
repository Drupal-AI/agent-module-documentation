#!/usr/bin/env bash
# PASS when buty_tbl table filter has table_row_striping enabled.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f=FilterFormat::load("buty_tbl"); $on=FALSE;
  if($f && ($flt=$f->filters()->get("bootstrap_utilities_table_filter"))){ $on=(bool)($flt->status) && !empty($flt->settings["table_row_striping"]); }
  print ($on?"PASS":"FAIL")." striped=".var_export($on,TRUE)."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
