#!/usr/bin/env bash
# Introspection SETUP: create a CKEditor 5 text format (ckabbr_html) with the abbreviation
# button AND an allowed_html list that permits <abbr title>, so an agent can confirm the
# tooltip-preserving markup configuration on the live site.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if ($e = Editor::load("ckabbr_html")) { $e->delete(); }
  if ($f = FilterFormat::load("ckabbr_html")) { $f->delete(); }
  FilterFormat::create([
    "format" => "ckabbr_html", "name" => "CKAbbr Html", "weight" => 31,
    "filters" => ["filter_html" => ["status" => TRUE, "settings" => ["allowed_html" => "<p> <br> <a href> <abbr title>"]]],
  ])->save();
  Editor::create([
    "format" => "ckabbr_html", "editor" => "ckeditor5",
    "settings" => ["toolbar" => ["items" => ["abbreviation"]], "plugins" => []],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ckabbr_html allows <abbr title> in filter_html and has the abbreviation button"
