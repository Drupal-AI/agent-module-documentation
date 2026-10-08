#!/usr/bin/env bash
# Execution RESET: text format buty_tbl with the table filter enabled but striped rows OFF.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f=FilterFormat::load("buty_tbl"); if(!$f){$f=FilterFormat::create(["format"=>"buty_tbl","name"=>"BUTY Tbl","weight"=>43]);}
  $f->setFilterConfig("bootstrap_utilities_table_filter",["status"=>TRUE,"weight"=>10,"settings"=>["table_remove_width_height"=>TRUE,"table_row_striping"=>FALSE,"table_bordered"=>FALSE,"table_row_hover"=>FALSE,"table_small"=>FALSE]]);
  $f->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: buty_tbl table filter enabled, striped OFF"
