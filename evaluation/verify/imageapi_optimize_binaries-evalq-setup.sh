#!/usr/bin/env bash
# Introspection SETUP: create Image Optimize pipeline "imageapi_bin_evalq" with a jpegoptim
# processor whose JPEG quality is 77, so an inspecting agent can read it back. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("imageapi_optimize_pipeline");
  if ($p = $s->load("imageapi_bin_evalq")) { $p->delete(); }
  $p = $s->create(["name" => "imageapi_bin_evalq", "label" => "Imageapi Bin Evalq"]);
  $p->addProcessor(["id" => "jpegoptim", "weight" => 1, "data" => [
    "manual_executable_path" => "", "progressive" => "", "quality" => 77, "size" => "",
  ]]);
  $p->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: pipeline imageapi_bin_evalq with jpegoptim quality=77"
