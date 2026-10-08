#!/usr/bin/env bash
# Execution RESET: create a CKEditor 5 format 'chte_hard2' WITHOUT htmlEmbed so verify FAILS.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if ($e = Editor::load("chte_hard2")) { $e->delete(); }
  if ($f = FilterFormat::load("chte_hard2")) { $f->delete(); }
  FilterFormat::create(["format" => "chte_hard2", "name" => "CHTE Hard2", "filters" => []])->save();
  Editor::create([
    "format" => "chte_hard2", "editor" => "ckeditor5",
    "settings" => ["toolbar" => ["items" => ["heading", "bold"]], "plugins" => []],
    "image_upload" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: format chte_hard2 exists with a CKEditor 5 toolbar that has NO htmlEmbed"
