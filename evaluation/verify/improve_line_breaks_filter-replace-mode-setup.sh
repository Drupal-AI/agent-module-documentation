#!/usr/bin/env bash
# Introspection SETUP: create text format ilbf_replace with the improve_line_breaks_filter
# enabled and remove_empty_paragraphs = FALSE (replace with <br />, not delete). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $format = FilterFormat::load("ilbf_replace");
  if (!$format) {
    $format = FilterFormat::create(["format" => "ilbf_replace", "name" => "ILBF Replace"]);
  }
  $format->setFilterConfig("improve_line_breaks_filter", [
    "status" => TRUE, "weight" => 50,
    "settings" => ["remove_empty_paragraphs" => FALSE],
  ]);
  $format->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: filter.format.ilbf_replace improve_line_breaks_filter remove_empty_paragraphs=FALSE"
