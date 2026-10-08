#!/usr/bin/env bash
# Execution RESET: ensure text format rtf_wrap exists with responsive_table_filter ENABLED using
# the default wrapper_element (figure), so verify (which wants 'div') FAILS until the agent
# changes it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("rtf_wrap");
  if (!$f) {
    $f = FilterFormat::create(["format" => "rtf_wrap", "name" => "RTF Wrap"]);
  }
  $f->setFilterConfig("filter_responsive_table", [
    "status" => TRUE,
    "settings" => ["wrapper_element" => "figure", "wrapper_classes" => "responsive-figure-table"],
  ]);
  $f->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: format rtf_wrap has filter enabled with wrapper_element=figure"
