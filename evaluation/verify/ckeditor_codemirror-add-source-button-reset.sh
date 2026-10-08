#!/usr/bin/env bash
# Execution RESET: ensure the CKEditor 5 text format `ckeditor_codemirror_nosrc` exists with
# a toolbar that does NOT contain sourceEditing and no CodeMirror settings. The agent must
# add the Source button (the plugin's condition) *and* enable CodeMirror in PHP mode with
# code folding. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if (!FilterFormat::load("ckeditor_codemirror_nosrc")) {
    FilterFormat::create([
      "format" => "ckeditor_codemirror_nosrc",
      "name" => "CodeMirror No Source Format",
      "weight" => 53,
      "filters" => [],
    ])->save();
  }
  $settings = [
    "toolbar" => ["items" => ["bold", "italic"]],
    "plugins" => [],
  ];
  $editor = Editor::load("ckeditor_codemirror_nosrc");
  if (!$editor) {
    $editor = Editor::create([
      "format" => "ckeditor_codemirror_nosrc", "editor" => "ckeditor5",
      "settings" => $settings, "image_upload" => ["status" => FALSE],
    ]);
  }
  else {
    $editor->setSettings($settings);
  }
  $editor->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: ckeditor_codemirror_nosrc has no sourceEditing item and no CodeMirror settings"
