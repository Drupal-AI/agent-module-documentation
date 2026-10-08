#!/usr/bin/env bash
# Introspection SETUP: create a text format with the TOC filter enabled using TOC type 'simple'.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("toc_filter_med2") ?: FilterFormat::create(["format" => "toc_filter_med2", "name" => "TOC Filter Med2"]);
  $f->setFilterConfig("toc_filter", [
    "status" => TRUE, "weight" => 0,
    "settings" => ["type" => "simple", "auto" => "", "block" => TRUE, "exclude_above" => FALSE],
  ]);
  $f->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: format toc_filter_med2 has toc_filter enabled with type=simple, block=true"
