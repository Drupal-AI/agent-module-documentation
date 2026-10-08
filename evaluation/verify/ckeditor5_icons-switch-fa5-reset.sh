#!/usr/bin/env bash
# Execution RESET: (re)create the text format `ckeditor5_icons_legacy` whose CKEditor 5 editor
# already has the icon picker but configured for Font Awesome 6 with styles
# [solid, regular, brands] — so verify FAILS until the agent switches it to Font Awesome 5
# and narrows the styles to solid + brands only.
# Namespaced to this module. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if (!FilterFormat::load("ckeditor5_icons_legacy")) {
    FilterFormat::create([
      "format" => "ckeditor5_icons_legacy",
      "name" => "CKEditor5 Icons Legacy",
      "weight" => 33,
      "filters" => [],
    ])->save();
  }
  $settings = [
    "toolbar" => ["items" => ["bold", "italic", "icon"]],
    "plugins" => [
      "ckeditor5_icons_icon" => [
        "fa_version" => "6",
        "fa_styles" => ["solid", "regular", "brands"],
        "custom_metadata" => FALSE,
        "async_metadata" => TRUE,
        "recommended_enabled" => FALSE,
      ],
    ],
  ];
  if ($editor = Editor::load("ckeditor5_icons_legacy")) { $editor->setSettings($settings)->save(); }
  else { Editor::create(["format" => "ckeditor5_icons_legacy", "editor" => "ckeditor5", "settings" => $settings, "image_upload" => []])->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: editor.editor.ckeditor5_icons_legacy fa_version=6, fa_styles=[solid,regular,brands]"
