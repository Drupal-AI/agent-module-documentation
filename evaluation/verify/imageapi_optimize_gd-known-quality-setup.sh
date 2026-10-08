#!/usr/bin/env bash
# Introspection SETUP: create an Image Optimize pipeline "iaogd_known" containing a single GD
# (imageapi_optimize_gd) processor set to quality 42 for JPEG, so an inspecting agent can read
# back the configured quality. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\imageapi_optimize\Entity\ImageAPIOptimizePipeline;
  if ($e = ImageAPIOptimizePipeline::load("iaogd_known")) { $e->delete(); }
  ImageAPIOptimizePipeline::create([
    "name" => "iaogd_known", "label" => "IAOGD Known",
    "processors" => [[
      "id" => "imageapi_optimize_gd", "weight" => 0,
      "uuid" => \Drupal::service("uuid")->generate(),
      "data" => ["quality" => 42, "file_types" => ["image/jpeg" => "image/jpeg"]],
    ]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: pipeline iaogd_known has an imageapi_optimize_gd processor with quality=42"
