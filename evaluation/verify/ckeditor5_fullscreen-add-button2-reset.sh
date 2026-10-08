#!/usr/bin/env bash
# Execution RESET: create/reset a namespaced text format ck5fs_task2 with a ckeditor5 editor
# using a different starting toolbar (includes sourceEditing/link, still no Fullscreen) so
# verify FAILS until the agent adds it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if (!FilterFormat::load("ck5fs_task2")) {
    FilterFormat::create(["format" => "ck5fs_task2", "name" => "CK5FS Task 2", "filters" => []])->save();
  }
  if ($ed = Editor::load("ck5fs_task2")) { $ed->delete(); }
  Editor::create([
    "editor" => "ckeditor5",
    "format" => "ck5fs_task2",
    "settings" => [
      "toolbar" => ["items" => ["heading", "bold", "italic", "link", "sourceEditing"]],
      "plugins" => [],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: ck5fs_task2 present, Fullscreen absent from its CKEditor5 toolbar"
