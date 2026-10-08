#!/usr/bin/env bash
# Introspection SETUP: create a namespaced text format ck5fs_eval with a ckeditor5 editor
# whose toolbar INCLUDES the Fullscreen button, so an inspecting agent can read back that it
# is present. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if (!FilterFormat::load("ck5fs_eval")) {
    FilterFormat::create(["format" => "ck5fs_eval", "name" => "CK5FS Eval", "filters" => []])->save();
  }
  if ($ed = Editor::load("ck5fs_eval")) { $ed->delete(); }
  Editor::create([
    "editor" => "ckeditor5",
    "format" => "ck5fs_eval",
    "settings" => [
      "toolbar" => ["items" => ["bold", "italic", "Fullscreen"]],
      "plugins" => [],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ck5fs_eval created with Fullscreen in its CKEditor5 toolbar"
