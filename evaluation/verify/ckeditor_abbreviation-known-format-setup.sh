#!/usr/bin/env bash
# Introspection SETUP: create a CKEditor 5 text format (ckabbr_known) whose toolbar already
# has the CKEditor Abbreviation button, so an agent can discover which format has it enabled.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if ($e = Editor::load("ckabbr_known")) { $e->delete(); }
  if ($f = FilterFormat::load("ckabbr_known")) { $f->delete(); }
  FilterFormat::create([
    "format" => "ckabbr_known", "name" => "CKAbbr Known", "weight" => 30,
    "filters" => ["filter_html" => ["status" => TRUE, "settings" => ["allowed_html" => "<p> <br> <em> <strong> <abbr title>"]]],
  ])->save();
  Editor::create([
    "format" => "ckabbr_known", "editor" => "ckeditor5",
    "settings" => ["toolbar" => ["items" => ["bold", "italic", "abbreviation"]], "plugins" => []],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: text format ckabbr_known has the abbreviation toolbar item enabled"
