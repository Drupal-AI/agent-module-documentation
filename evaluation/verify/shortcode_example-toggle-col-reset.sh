#!/usr/bin/env bash
# Execution RESET: (re)create the namespaced text format `sce_task2` with the shortcode filter
# already enabled but the `col` tag explicitly OFF, so verify FAILS until the agent turns col
# on. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("sce_task2")) { $f->delete(); }
  FilterFormat::create([
    "format" => "sce_task2",
    "name" => "Shortcode Example Task 2",
    "filters" => [
      "shortcode" => ["status" => TRUE, "weight" => 0, "settings" => ["col" => FALSE]],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: sce_task2 has shortcode filter enabled, col=FALSE"
