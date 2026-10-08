#!/usr/bin/env bash
# Introspection SETUP: create a text format rtf_known with the responsive_table_filter enabled
# and a known custom wrapper_element (section) and wrapper_classes (rtf-scroll-known). An
# inspecting agent should read the format config and report the wrapper element. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("rtf_known");
  if (!$f) {
    $f = FilterFormat::create(["format" => "rtf_known", "name" => "RTF Known"]);
  }
  $f->setFilterConfig("filter_responsive_table", [
    "status" => TRUE,
    "settings" => ["wrapper_element" => "section", "wrapper_classes" => "rtf-scroll-known"],
  ]);
  $f->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: format rtf_known has filter_responsive_table enabled, wrapper_element=section"
