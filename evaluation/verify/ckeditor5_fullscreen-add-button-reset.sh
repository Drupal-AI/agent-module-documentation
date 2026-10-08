#!/usr/bin/env bash
# Execution RESET: create/reset a namespaced text format ck5fs_task with a ckeditor5 editor
# whose toolbar does NOT include Fullscreen (so verify FAILS until the agent adds it).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if (!FilterFormat::load("ck5fs_task")) {
    FilterFormat::create(["format" => "ck5fs_task", "name" => "CK5FS Task", "filters" => []])->save();
  }
  if ($ed = Editor::load("ck5fs_task")) { $ed->delete(); }
  Editor::create([
    "editor" => "ckeditor5",
    "format" => "ck5fs_task",
    "settings" => [
      "toolbar" => ["items" => ["bold", "italic"]],
      "plugins" => [],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: ck5fs_task present, Fullscreen absent from its CKEditor5 toolbar"
