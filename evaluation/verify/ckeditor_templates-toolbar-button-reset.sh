#!/usr/bin/env bash
# Execution RESET: ensure a CKEditor 5 text format `ckeditor_templates_eval` exists WITHOUT
# the ckeditorTemplates toolbar item and without ckeditor_templates_plugin settings, so
# verify FAILS until the agent wires the Templates button up. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if (!FilterFormat::load("ckeditor_templates_eval")) {
    FilterFormat::create([
      "format" => "ckeditor_templates_eval",
      "name" => "CKEditor Templates Eval Format",
      "weight" => 54,
      "filters" => [],
    ])->save();
  }
  $settings = [
    "toolbar" => ["items" => ["bold", "italic"]],
    "plugins" => [],
  ];
  $editor = Editor::load("ckeditor_templates_eval");
  if (!$editor) {
    $editor = Editor::create([
      "format" => "ckeditor_templates_eval", "editor" => "ckeditor5",
      "settings" => $settings, "image_upload" => ["status" => FALSE],
    ]);
  }
  else {
    $editor->setSettings($settings);
  }
  $editor->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: ckeditor_templates_eval format has no ckeditorTemplates toolbar item"
