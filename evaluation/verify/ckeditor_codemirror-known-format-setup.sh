#!/usr/bin/env bash
# Introspection SETUP: create a CKEditor 5 text format `ckeditor_codemirror_eval` whose
# CodeMirror source-editing plugin is enabled with the SCSS mode (text/x-scss), so an
# inspecting agent can read the mode back from editor.editor.ckeditor_codemirror_eval.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if (!FilterFormat::load("ckeditor_codemirror_eval")) {
    FilterFormat::create([
      "format" => "ckeditor_codemirror_eval",
      "name" => "CodeMirror Eval Format",
      "weight" => 50,
      "filters" => [],
    ])->save();
  }
  $settings = [
    "toolbar" => ["items" => ["bold", "italic", "sourceEditing"]],
    "plugins" => [
      "ckeditor5_sourceEditing" => ["allowed_tags" => []],
      "ckeditor_codemirror_source_editing" => [
        "enable" => TRUE,
        "mode" => "text/x-scss",
        "options" => [
          "autoCloseBrackets" => TRUE, "autoCloseTags" => TRUE, "folding" => TRUE,
          "lineNumbers" => TRUE, "lineWrapping" => TRUE, "matchBrackets" => TRUE,
          "matchTags" => TRUE, "searchBottom" => TRUE, "styleActiveLine" => TRUE,
        ],
      ],
    ],
  ];
  $editor = Editor::load("ckeditor_codemirror_eval");
  if (!$editor) {
    $editor = Editor::create([
      "format" => "ckeditor_codemirror_eval",
      "editor" => "ckeditor5",
      "settings" => $settings,
      "image_upload" => ["status" => FALSE],
    ]);
  }
  else {
    $editor->setSettings($settings);
  }
  $editor->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: editor.editor.ckeditor_codemirror_eval has ckeditor_codemirror_source_editing enable=true mode=text/x-scss"
