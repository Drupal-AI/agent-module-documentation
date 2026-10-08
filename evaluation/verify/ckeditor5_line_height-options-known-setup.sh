#!/usr/bin/env bash
# Introspection SETUP: create a CKEditor 5 text format 'clh_known' whose toolbar has the
# Line Height button, with a distinctive custom option list, so an agent can read it back.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if (!FilterFormat::load("clh_known")) {
    FilterFormat::create(["format" => "clh_known", "name" => "CLH Known", "filters" => []])->save();
  }
  $ed = Editor::load("clh_known");
  if (!$ed) { $ed = Editor::create(["format" => "clh_known", "editor" => "ckeditor5"]); }
  $ed->setSettings([
    "toolbar" => ["items" => ["bold", "italic", "lineHeight"]],
    "plugins" => ["ckeditor5_line_height_line_height" => ["line_height_options" => ["1.15", "1.35", "1.85"]]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: editor.editor.clh_known toolbar has lineHeight, options=1.15 1.35 1.85"
