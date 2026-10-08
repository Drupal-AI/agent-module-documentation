#!/usr/bin/env bash
# Introspection SETUP: pipeline iowr_q with WebP Deriver at quality 85.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\imageapi_optimize\Entity\ImageAPIOptimizePipeline;
  \Drupal::configFactory()->getEditable("imageapi_optimize.pipeline.iowr_q")->delete();
  $u = \Drupal::service("uuid")->generate();
  ImageAPIOptimizePipeline::create(["name"=>"iowr_q","label"=>"IOWR Q","processors"=>[$u=>["id"=>"imageapi_optimize_webp","data"=>["quality"=>85],"weight"=>0,"uuid"=>$u]]])->save();
' >/dev/null 2>&1
echo "setup: pipeline iowr_q WebP Deriver quality 85"
