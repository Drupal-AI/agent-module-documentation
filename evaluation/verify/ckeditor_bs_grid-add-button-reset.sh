#!/usr/bin/env bash
# Execution RESET: (re)create the text format ckbsgrid_plain with a CKEditor 5 editor that does
# NOT have the Bootstrap Grid button and has no ckeditor_bs_grid_grid plugin settings, so verify
# fails until the agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if ($e = Editor::load("ckbsgrid_plain")) { $e->delete(); }
  if ($f = FilterFormat::load("ckbsgrid_plain")) { $f->delete(); }
  FilterFormat::create([
    "format" => "ckbsgrid_plain", "name" => "CKBSGrid Plain", "weight" => 21, "filters" => [],
  ])->save();
  Editor::create([
    "format" => "ckbsgrid_plain", "editor" => "ckeditor5",
    "settings" => ["toolbar" => ["items" => ["bold", "italic"]], "plugins" => []],
  ])->save();
  $e = Editor::load("ckbsgrid_plain");
  print "reset: toolbar=" . implode(",", $e->getSettings()["toolbar"]["items"]) . "\n";
' 2>/dev/null
drush cr >/dev/null 2>&1
exit 0
