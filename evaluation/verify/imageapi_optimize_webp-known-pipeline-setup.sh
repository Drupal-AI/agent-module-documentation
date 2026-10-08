#!/usr/bin/env bash
# Introspection SETUP: create an Image Optimize pipeline iow_intro with the WebP Deriver processor
# at quality 60, so an agent can inspect it and report the processor id / quality.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\imageapi_optimize\Entity\ImageAPIOptimizePipeline;
  \Drupal::configFactory()->getEditable("imageapi_optimize.pipeline.iow_intro")->delete();
  $u = \Drupal::service("uuid")->generate();
  ImageAPIOptimizePipeline::create(["name"=>"iow_intro","label"=>"IOW Intro","processors"=>[$u=>["id"=>"imageapi_optimize_webp","data"=>["quality"=>60],"weight"=>0,"uuid"=>$u]]])->save();
' >/dev/null 2>&1
echo "setup: pipeline iow_intro has imageapi_optimize_webp processor at quality 60"
