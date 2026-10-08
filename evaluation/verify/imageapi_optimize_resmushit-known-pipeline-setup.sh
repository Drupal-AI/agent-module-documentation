#!/usr/bin/env bash
# Introspection SETUP: create a KNOWN imageapi_optimize_pipeline that contains the
# reSmush.it (resmushit) processor with quality 65, so an inspecting agent can read it back.
# Pipeline id: eval_resmushit_known. Idempotent (recreated each run). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\imageapi_optimize\Entity\ImageAPIOptimizePipeline;
  if ($old = \Drupal::entityTypeManager()->getStorage("imageapi_optimize_pipeline")->load("eval_resmushit_known")) { $old->delete(); }
  $p = ImageAPIOptimizePipeline::create(["name" => "eval_resmushit_known", "label" => "Eval reSmush.it Known"]);
  $p->addProcessor(["id" => "resmushit", "data" => ["quality" => 65], "weight" => 0]);
  $p->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: imageapi_optimize.pipeline.eval_resmushit_known created (resmushit, quality 65)"
