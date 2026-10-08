#!/usr/bin/env bash
# Introspection SETUP: create text format 'iri_reval' with the inline_responsive_images
# 'Display responsive images' filter (filter_responsive_image_style) enabled and responsive
# image styles narrow+wide selected. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $ff = \Drupal\filter\Entity\FilterFormat::load("iri_reval");
  if (!$ff) { $ff = \Drupal\filter\Entity\FilterFormat::create(["format"=>"iri_reval","name"=>"IRI Responsive Eval"]); }
  $ff->setFilterConfig("filter_responsive_image_style", [
    "status" => TRUE, "weight" => 100,
    "settings" => ["image_styles" => ["narrow"=>"narrow","wide"=>"wide"]],
  ]);
  $ff->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: format iri_reval has filter_responsive_image_style enabled with narrow,wide"
