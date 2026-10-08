#!/usr/bin/env bash
# Execution RESET: ensure text format ilbf_remove exists with improve_line_breaks_filter
# enabled but remove_empty_paragraphs = FALSE (replace mode), so verify FAILS until the agent
# switches it to delete mode (remove_empty_paragraphs = TRUE). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $format = FilterFormat::load("ilbf_remove");
  if (!$format) {
    $format = FilterFormat::create(["format" => "ilbf_remove", "name" => "ILBF Remove"]);
  }
  $format->setFilterConfig("improve_line_breaks_filter", [
    "status" => TRUE, "weight" => 50,
    "settings" => ["remove_empty_paragraphs" => FALSE],
  ]);
  $format->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: filter.format.ilbf_remove improve_line_breaks_filter remove_empty_paragraphs=FALSE"
