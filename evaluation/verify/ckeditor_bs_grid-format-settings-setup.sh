#!/usr/bin/env bash
# Introspection SETUP: create a text format (ckbsgrid_eval) with CKEditor 5 and the Bootstrap
# Grid button enabled, configured with a known, non-default per-format plugin configuration, so
# the agent must read the live editor config to answer. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if ($e = Editor::load("ckbsgrid_eval")) { $e->delete(); }
  if ($f = FilterFormat::load("ckbsgrid_eval")) { $f->delete(); }
  FilterFormat::create([
    "format" => "ckbsgrid_eval", "name" => "CKBSGrid Eval", "weight" => 20, "filters" => [],
  ])->save();
  Editor::create([
    "format" => "ckbsgrid_eval", "editor" => "ckeditor5",
    "settings" => [
      "toolbar" => ["items" => ["bold", "italic", "bootstrapGrid"]],
      "plugins" => [
        "ckeditor_bs_grid_grid" => [
          "use_cdn" => FALSE,
          "cdn_url" => "https://cdn.example.com/bootstrap-grid.min.css",
          "available_columns" => ["1", "2", "3"],
          "available_breakpoints" => ["xs", "md"],
        ],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
drush php:eval '
  $e = \Drupal\editor\Entity\Editor::load("ckbsgrid_eval");
  print "setup: " . ($e ? json_encode($e->getSettings()["plugins"]["ckeditor_bs_grid_grid"]) : "MISSING") . "\n";
' 2>/dev/null
exit 0
