#!/usr/bin/env bash
# Execution RESET: (re)create the text format `ckeditor5_icons_task` with a CKEditor 5 editor
# that does NOT have the icon picker — no `icon` toolbar item and no ckeditor5_icons_icon
# plugin settings — so verify FAILS until the agent enables and configures it.
# Namespaced to this module. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if (!FilterFormat::load("ckeditor5_icons_task")) {
    FilterFormat::create([
      "format" => "ckeditor5_icons_task",
      "name" => "CKEditor5 Icons Task",
      "weight" => 32,
      "filters" => [],
    ])->save();
  }
  $settings = [
    "toolbar" => ["items" => ["bold", "italic", "link"]],
    "plugins" => [],
  ];
  if ($editor = Editor::load("ckeditor5_icons_task")) { $editor->setSettings($settings)->save(); }
  else { Editor::create(["format" => "ckeditor5_icons_task", "editor" => "ckeditor5", "settings" => $settings, "image_upload" => []])->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: editor.editor.ckeditor5_icons_task has no icon toolbar item and no ckeditor5_icons_icon settings"
