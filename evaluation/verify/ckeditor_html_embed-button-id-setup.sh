#!/usr/bin/env bash
# Introspection SETUP: create CKEditor 5 format 'chte_med2' including HTML embed.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if ($e = Editor::load("chte_med2")) { $e->delete(); }
  if ($f = FilterFormat::load("chte_med2")) { $f->delete(); }
  FilterFormat::create(["format" => "chte_med2", "name" => "CHTE Med2", "filters" => []])->save();
  Editor::create([
    "format" => "chte_med2", "editor" => "ckeditor5",
    "settings" => ["toolbar" => ["items" => ["heading", "htmlEmbed", "link"]], "plugins" => []],
    "image_upload" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: format chte_med2 CKEditor 5 toolbar includes the htmlEmbed item"
