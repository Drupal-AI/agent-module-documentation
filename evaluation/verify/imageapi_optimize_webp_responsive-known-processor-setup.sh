#!/usr/bin/env bash
# Introspection SETUP: create an Image Optimize pipeline iowr_intro with the WebP Deriver processor,
# the prerequisite that makes imageapi_optimize_webp_responsive emit WebP <source>s.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\imageapi_optimize\Entity\ImageAPIOptimizePipeline;
  \Drupal::configFactory()->getEditable("imageapi_optimize.pipeline.iowr_intro")->delete();
  $u = \Drupal::service("uuid")->generate();
  ImageAPIOptimizePipeline::create(["name"=>"iowr_intro","label"=>"IOWR Intro","processors"=>[$u=>["id"=>"imageapi_optimize_webp","data"=>["quality"=>70],"weight"=>0,"uuid"=>$u]]])->save();
' >/dev/null 2>&1
echo "setup: pipeline iowr_intro has the imageapi_optimize_webp processor"
