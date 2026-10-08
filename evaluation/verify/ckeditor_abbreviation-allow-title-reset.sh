#!/usr/bin/env bash
# Execution RESET: create a CKEditor 5 text format (ckabbr_title) that HAS the abbreviation
# button but whose filter_html allowed_html does NOT permit <abbr title> (so tooltips would be
# stripped). verify FAILS until the agent allows <abbr title>. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if ($e = Editor::load("ckabbr_title")) { $e->delete(); }
  if ($f = FilterFormat::load("ckabbr_title")) { $f->delete(); }
  FilterFormat::create([
    "format" => "ckabbr_title", "name" => "CKAbbr Title", "weight" => 33,
    "filters" => ["filter_html" => ["status" => TRUE, "settings" => ["allowed_html" => "<p> <br> <strong> <em>"]]],
  ])->save();
  Editor::create([
    "format" => "ckabbr_title", "editor" => "ckeditor5",
    "settings" => ["toolbar" => ["items" => ["bold", "abbreviation"]], "plugins" => []],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: ckabbr_title has abbreviation button but allowed_html lacks <abbr title>"
