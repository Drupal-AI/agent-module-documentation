#!/usr/bin/env bash
# Execution RESET: create a CKEditor 5 text format (ckabbr_task) WITHOUT the abbreviation
# button in its toolbar, so verify FAILS until the agent adds it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if ($e = Editor::load("ckabbr_task")) { $e->delete(); }
  if ($f = FilterFormat::load("ckabbr_task")) { $f->delete(); }
  FilterFormat::create([
    "format" => "ckabbr_task", "name" => "CKAbbr Task", "weight" => 32,
    "filters" => ["filter_html" => ["status" => TRUE, "settings" => ["allowed_html" => "<p> <br> <strong> <em> <abbr title>"]]],
  ])->save();
  Editor::create([
    "format" => "ckabbr_task", "editor" => "ckeditor5",
    "settings" => ["toolbar" => ["items" => ["bold", "italic"]], "plugins" => []],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: text format ckabbr_task present WITHOUT the abbreviation button"
