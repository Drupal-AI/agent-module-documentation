#!/usr/bin/env bash
# Execution RESET: (re)create the namespaced text format `sbt_task` with NO shortcode filter
# configured at all, so verify FAILS until the agent enables the filter AND the `quote` tag.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("sbt_task")) { $f->delete(); }
  FilterFormat::create([
    "format" => "sbt_task",
    "name" => "Shortcode Basic Tags Task",
    "filters" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: sbt_task exists with no shortcode filter configured"
