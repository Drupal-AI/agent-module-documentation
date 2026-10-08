#!/usr/bin/env bash
# Execution RESET: ensure text format ilbf_task exists WITHOUT the improve_line_breaks_filter
# (filter disabled), so verify FAILS until the agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $format = FilterFormat::load("ilbf_task");
  if (!$format) {
    $format = FilterFormat::create(["format" => "ilbf_task", "name" => "ILBF Task"]);
  }
  $format->setFilterConfig("improve_line_breaks_filter", ["status" => FALSE]);
  $format->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: filter.format.ilbf_task without improve_line_breaks_filter (status=FALSE)"
