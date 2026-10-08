#!/usr/bin/env bash
# Introspection SETUP: create text format ilbf_known with the improve_line_breaks_filter
# enabled and remove_empty_paragraphs = TRUE. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $format = FilterFormat::load("ilbf_known");
  if (!$format) {
    $format = FilterFormat::create(["format" => "ilbf_known", "name" => "ILBF Known"]);
  }
  $format->setFilterConfig("improve_line_breaks_filter", [
    "status" => TRUE, "weight" => 50,
    "settings" => ["remove_empty_paragraphs" => TRUE],
  ]);
  $format->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: filter.format.ilbf_known improve_line_breaks_filter status=TRUE remove_empty_paragraphs=TRUE"
