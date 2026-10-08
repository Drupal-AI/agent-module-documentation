#!/usr/bin/env bash
# Execution RESET: (re)create the namespaced text format `sce_task` with NO shortcode filter
# configured at all, so verify FAILS until the agent enables the filter AND the `col` tag.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("sce_task")) { $f->delete(); }
  FilterFormat::create([
    "format" => "sce_task",
    "name" => "Shortcode Example Task",
    "filters" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: sce_task exists with no shortcode filter configured"
