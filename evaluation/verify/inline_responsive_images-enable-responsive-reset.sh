#!/usr/bin/env bash
# Execution RESET: create text format 'iri_rtask' with the 'Display responsive images' filter
# (filter_responsive_image_style) present but DISABLED and no styles, so verify FAILS until the
# agent enables it and picks a responsive style. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $ff = \Drupal\filter\Entity\FilterFormat::load("iri_rtask");
  if (!$ff) { $ff = \Drupal\filter\Entity\FilterFormat::create(["format"=>"iri_rtask","name"=>"IRI Responsive Task"]); }
  $ff->setFilterConfig("filter_responsive_image_style", [
    "status" => FALSE, "weight" => 100,
    "settings" => ["image_styles" => []],
  ]);
  $ff->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: format iri_rtask has filter_responsive_image_style DISABLED with no styles"
