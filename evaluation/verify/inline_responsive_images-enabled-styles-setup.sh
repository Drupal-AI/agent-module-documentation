#!/usr/bin/env bash
# Introspection SETUP: create text format 'iri_eval' with the inline_responsive_images
# 'Display image styles' filter (filter_imagestyle) enabled and image styles thumbnail+large
# selected, so an agent can read back which styles are exposed. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $ff = \Drupal\filter\Entity\FilterFormat::load("iri_eval");
  if (!$ff) { $ff = \Drupal\filter\Entity\FilterFormat::create(["format"=>"iri_eval","name"=>"IRI Eval"]); }
  $ff->setFilterConfig("filter_imagestyle", [
    "status" => TRUE, "weight" => 100,
    "settings" => ["image_styles" => ["thumbnail"=>"thumbnail","large"=>"large"]],
  ]);
  $ff->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: format iri_eval has filter_imagestyle enabled with image_styles thumbnail,large"
