#!/usr/bin/env bash
# Execution RESET: create a format with toc_filter enabled but auto='' so verify FAILS until
# the agent sets auto=top.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("toc_filter_hard2")) { $f->delete(); }
  $f = FilterFormat::create(["format" => "toc_filter_hard2", "name" => "TOC Filter Hard2"]);
  $f->setFilterConfig("toc_filter", [
    "status" => TRUE, "weight" => 0,
    "settings" => ["type" => "default", "auto" => "", "block" => FALSE, "exclude_above" => FALSE],
  ]);
  $f->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: format toc_filter_hard2 has toc_filter enabled with auto=''"
