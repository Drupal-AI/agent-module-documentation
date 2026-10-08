#!/usr/bin/env bash
# Introspection SETUP: create a CKEditor 5 format 'chte_med' with the htmlEmbed button enabled.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if ($e = Editor::load("chte_med")) { $e->delete(); }
  if ($f = FilterFormat::load("chte_med")) { $f->delete(); }
  FilterFormat::create(["format" => "chte_med", "name" => "CHTE Med", "filters" => []])->save();
  Editor::create([
    "format" => "chte_med", "editor" => "ckeditor5",
    "settings" => ["toolbar" => ["items" => ["bold", "htmlEmbed", "italic"]], "plugins" => []],
    "image_upload" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: format chte_med has htmlEmbed in its CKEditor 5 toolbar"
