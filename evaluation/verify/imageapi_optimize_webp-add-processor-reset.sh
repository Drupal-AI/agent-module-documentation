#!/usr/bin/env bash
# Execution RESET: create an Image Optimize pipeline iow_base with NO processors, so verify FAILS
# until the agent adds the WebP Deriver processor to it.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\imageapi_optimize\Entity\ImageAPIOptimizePipeline;
  \Drupal::configFactory()->getEditable("imageapi_optimize.pipeline.iow_base")->delete();
  ImageAPIOptimizePipeline::create(["name"=>"iow_base","label"=>"IOW Base","processors"=>[]])->save();
' >/dev/null 2>&1
echo "reset: pipeline iow_base created with no processors"
