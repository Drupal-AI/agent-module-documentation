#!/usr/bin/env bash
# Execution RESET: create a CKEditor 5 format 'chte_hard' WITHOUT htmlEmbed so verify FAILS.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if ($e = Editor::load("chte_hard")) { $e->delete(); }
  if ($f = FilterFormat::load("chte_hard")) { $f->delete(); }
  FilterFormat::create(["format" => "chte_hard", "name" => "CHTE Hard", "filters" => []])->save();
  Editor::create([
    "format" => "chte_hard", "editor" => "ckeditor5",
    "settings" => ["toolbar" => ["items" => ["bold", "italic", "link"]], "plugins" => []],
    "image_upload" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: format chte_hard exists with a CKEditor 5 toolbar that has NO htmlEmbed"
