#!/usr/bin/env bash
# Execution RESET: (re)create the namespaced text format `shortcode_task2` with the shortcode
# filter already enabled but the `highlight` shortcode explicitly OFF, so verify FAILS until
# the agent turns highlight on. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("shortcode_task2")) { $f->delete(); }
  FilterFormat::create([
    "format" => "shortcode_task2",
    "name" => "Shortcode Task 2",
    "filters" => [
      "shortcode" => ["status" => TRUE, "weight" => 0, "settings" => ["quote" => TRUE, "highlight" => FALSE]],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: shortcode_task2 has shortcode filter enabled, highlight=FALSE"
