#!/usr/bin/env bash
# Introspection SETUP: create Image Optimize pipeline "imageapi_bin_evalp" with a pngquant
# processor whose manual_executable_path is /opt/custom/bin/pngquant. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("imageapi_optimize_pipeline");
  if ($p = $s->load("imageapi_bin_evalp")) { $p->delete(); }
  $p = $s->create(["name" => "imageapi_bin_evalp", "label" => "Imageapi Bin Evalp"]);
  $p->addProcessor(["id" => "pngquant", "weight" => 1, "data" => [
    "manual_executable_path" => "/opt/custom/bin/pngquant", "speed" => 3,
    "quality" => ["min" => 90, "max" => 99],
  ]]);
  $p->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: pipeline imageapi_bin_evalp with pngquant manual_executable_path=/opt/custom/bin/pngquant"
