#!/usr/bin/env bash
# Introspection SETUP: create a text format with the TOC filter enabled and auto=bottom.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("toc_filter_med") ?: FilterFormat::create(["format" => "toc_filter_med", "name" => "TOC Filter Med"]);
  $f->setFilterConfig("toc_filter", [
    "status" => TRUE, "weight" => 0,
    "settings" => ["type" => "default", "auto" => "bottom", "block" => FALSE, "exclude_above" => FALSE],
  ]);
  $f->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: format toc_filter_med has toc_filter enabled with auto=bottom"
