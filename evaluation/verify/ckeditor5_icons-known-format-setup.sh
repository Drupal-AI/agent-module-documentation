#!/usr/bin/env bash
# Introspection SETUP: create a dedicated text format `ckeditor5_icons_eval` with a CKEditor 5
# editor that has the `icon` toolbar button and a KNOWN ckeditor5_icons_icon configuration
# (Font Awesome 5, styles solid+brands, async metadata OFF, Recommended enabled with a fixed
# icon list) so an inspecting agent can read the live editor.editor config back.
# Namespaced to this module. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if (!FilterFormat::load("ckeditor5_icons_eval")) {
    FilterFormat::create([
      "format" => "ckeditor5_icons_eval",
      "name" => "CKEditor5 Icons Eval",
      "weight" => 30,
      "filters" => [],
    ])->save();
  }
  $settings = [
    "toolbar" => ["items" => ["bold", "italic", "icon"]],
    "plugins" => [
      "ckeditor5_icons_icon" => [
        "fa_version" => "5",
        "fa_styles" => ["solid", "brands"],
        "custom_metadata" => FALSE,
        "async_metadata" => FALSE,
        "recommended_enabled" => TRUE,
        "recommended_icons" => ["drupal", "heart", "star"],
      ],
    ],
  ];
  if ($editor = Editor::load("ckeditor5_icons_eval")) {
    $editor->setSettings($settings)->save();
  }
  else {
    Editor::create([
      "format" => "ckeditor5_icons_eval",
      "editor" => "ckeditor5",
      "settings" => $settings,
      "image_upload" => [],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: editor.editor.ckeditor5_icons_eval has ckeditor5_icons_icon fa_version=5, fa_styles=[solid,brands], async_metadata=false, recommended_icons=[drupal,heart,star]"
