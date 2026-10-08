#!/usr/bin/env bash
# Execution RESET: ensure the CKEditor 5 text format `ckeditor_codemirror_task` exists with
# the Source button in its toolbar but NO ckeditor_codemirror_source_editing settings, so
# verify FAILS until the agent enables CodeMirror with the SCSS mode. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if (!FilterFormat::load("ckeditor_codemirror_task")) {
    FilterFormat::create([
      "format" => "ckeditor_codemirror_task",
      "name" => "CodeMirror Task Format",
      "weight" => 52,
      "filters" => [],
    ])->save();
  }
  $settings = [
    "toolbar" => ["items" => ["bold", "italic", "sourceEditing"]],
    "plugins" => ["ckeditor5_sourceEditing" => ["allowed_tags" => []]],
  ];
  $editor = Editor::load("ckeditor_codemirror_task");
  if (!$editor) {
    $editor = Editor::create([
      "format" => "ckeditor_codemirror_task", "editor" => "ckeditor5",
      "settings" => $settings, "image_upload" => ["status" => FALSE],
    ]);
  }
  else {
    $editor->setSettings($settings);
  }
  $editor->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: ckeditor_codemirror_task exists with sourceEditing but no CodeMirror settings"
