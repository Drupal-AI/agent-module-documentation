#!/usr/bin/env bash
# Introspection SETUP: create a text format buty_format with the Bootstrap Utilities Table filter
# enabled (striped rows on), so an agent can read back which format uses it and how it is set.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("buty_format");
  if (!$f) {
    $f = FilterFormat::create(["format" => "buty_format", "name" => "BUTY Format", "weight" => 40]);
  }
  $f->setFilterConfig("bootstrap_utilities_table_filter", [
    "status" => TRUE, "weight" => 10,
    "settings" => [
      "table_remove_width_height" => TRUE, "table_row_striping" => TRUE,
      "table_bordered" => FALSE, "table_row_hover" => FALSE, "table_small" => FALSE,
    ],
  ]);
  $f->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: text format buty_format has bootstrap_utilities_table_filter enabled (striped on)"
