#!/usr/bin/env bash
# Execution RESET: create text format 'iri_task' with the 'Display image styles' filter
# (filter_imagestyle) present but DISABLED and no styles selected, so verify FAILS until the
# agent enables it and picks a style. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $ff = \Drupal\filter\Entity\FilterFormat::load("iri_task");
  if (!$ff) { $ff = \Drupal\filter\Entity\FilterFormat::create(["format"=>"iri_task","name"=>"IRI Task"]); }
  $ff->setFilterConfig("filter_imagestyle", [
    "status" => FALSE, "weight" => 100,
    "settings" => ["image_styles" => []],
  ]);
  $ff->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: format iri_task has filter_imagestyle DISABLED with no styles"
