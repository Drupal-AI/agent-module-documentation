#!/usr/bin/env bash
# Execution RESET: (re)create the namespaced text format `sbt_task2` with the shortcode filter
# already enabled but the `img` tag explicitly OFF, so verify FAILS until the agent turns img
# on. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if ($f = FilterFormat::load("sbt_task2")) { $f->delete(); }
  FilterFormat::create([
    "format" => "sbt_task2",
    "name" => "Shortcode Basic Tags Task 2",
    "filters" => [
      "shortcode" => ["status" => TRUE, "weight" => 0, "settings" => ["quote" => TRUE, "img" => FALSE]],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: sbt_task2 has shortcode filter enabled, img=FALSE"
