#!/usr/bin/env bash
# Introspection SETUP: create pipeline iow_quality with the WebP Deriver at quality 90.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\imageapi_optimize\Entity\ImageAPIOptimizePipeline;
  \Drupal::configFactory()->getEditable("imageapi_optimize.pipeline.iow_quality")->delete();
  $u = \Drupal::service("uuid")->generate();
  ImageAPIOptimizePipeline::create(["name"=>"iow_quality","label"=>"IOW Quality","processors"=>[$u=>["id"=>"imageapi_optimize_webp","data"=>["quality"=>90],"weight"=>0,"uuid"=>$u]]])->save();
' >/dev/null 2>&1
echo "setup: pipeline iow_quality WebP processor quality 90"
