#!/usr/bin/env bash
# Introspection SETUP: create two CKEditor 5 text formats that both carry the
# ckeditor_codemirror_source_editing settings block, but only `ckeditor_codemirror_on`
# has enable: true (`ckeditor_codemirror_off` has enable: false). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  $opts = [
    "autoCloseBrackets" => TRUE, "autoCloseTags" => TRUE, "folding" => TRUE,
    "lineNumbers" => TRUE, "lineWrapping" => TRUE, "matchBrackets" => TRUE,
    "matchTags" => TRUE, "searchBottom" => TRUE, "styleActiveLine" => TRUE,
  ];
  foreach ([["ckeditor_codemirror_on", "CodeMirror On", TRUE], ["ckeditor_codemirror_off", "CodeMirror Off", FALSE]] as [$id, $name, $enable]) {
    if (!FilterFormat::load($id)) {
      FilterFormat::create(["format" => $id, "name" => $name, "weight" => 51, "filters" => []])->save();
    }
    $settings = [
      "toolbar" => ["items" => ["bold", "sourceEditing"]],
      "plugins" => [
        "ckeditor5_sourceEditing" => ["allowed_tags" => []],
        "ckeditor_codemirror_source_editing" => [
          "enable" => $enable, "mode" => "htmlmixed", "options" => $opts,
        ],
      ],
    ];
    $editor = Editor::load($id);
    if (!$editor) {
      $editor = Editor::create([
        "format" => $id, "editor" => "ckeditor5",
        "settings" => $settings, "image_upload" => ["status" => FALSE],
      ]);
    }
    else {
      $editor->setSettings($settings);
    }
    $editor->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ckeditor_codemirror_on (enable=true) and ckeditor_codemirror_off (enable=false) created"
