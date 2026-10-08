#!/usr/bin/env bash
# Execution RESET: ensure a text format rtf_task exists with the responsive_table_filter present
# but DISABLED (status FALSE), so verify FAILS until the agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("rtf_task");
  if (!$f) {
    $f = FilterFormat::create(["format" => "rtf_task", "name" => "RTF Task"]);
  }
  $f->setFilterConfig("filter_responsive_table", ["status" => FALSE]);
  $f->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: format rtf_task present with filter_responsive_table DISABLED"
