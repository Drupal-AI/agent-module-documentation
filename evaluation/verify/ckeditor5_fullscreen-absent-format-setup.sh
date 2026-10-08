#!/usr/bin/env bash
# Introspection SETUP: create a namespaced text format ck5fs_eval2 with a ckeditor5 editor
# whose toolbar does NOT include the Fullscreen button, so an inspecting agent must confirm
# it is absent. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if (!FilterFormat::load("ck5fs_eval2")) {
    FilterFormat::create(["format" => "ck5fs_eval2", "name" => "CK5FS Eval 2", "filters" => []])->save();
  }
  if ($ed = Editor::load("ck5fs_eval2")) { $ed->delete(); }
  Editor::create([
    "editor" => "ckeditor5",
    "format" => "ck5fs_eval2",
    "settings" => [
      "toolbar" => ["items" => ["bold", "italic", "sourceEditing"]],
      "plugins" => [],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ck5fs_eval2 created WITHOUT Fullscreen in its CKEditor5 toolbar"
