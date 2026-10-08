#!/usr/bin/env bash
# Introspection SETUP: create TWO text formats that both have the ckeditor5_icons `icon`
# toolbar button, but with different enabled Font Awesome styles —
#   ckeditor5_icons_alpha: fa_styles = [solid, regular, brands]
#   ckeditor5_icons_beta : fa_styles = [brands]        (brand icons only)
# so the agent must read the live editor.editor config to tell which one is brands-only.
# Namespaced to this module. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  $defs = [
    "ckeditor5_icons_alpha" => ["CKEditor5 Icons Alpha", ["solid", "regular", "brands"]],
    "ckeditor5_icons_beta"  => ["CKEditor5 Icons Beta",  ["brands"]],
  ];
  foreach ($defs as $id => [$label, $styles]) {
    if (!FilterFormat::load($id)) {
      FilterFormat::create(["format" => $id, "name" => $label, "weight" => 31, "filters" => []])->save();
    }
    $settings = [
      "toolbar" => ["items" => ["bold", "icon"]],
      "plugins" => [
        "ckeditor5_icons_icon" => [
          "fa_version" => "6",
          "fa_styles" => $styles,
          "custom_metadata" => FALSE,
          "async_metadata" => TRUE,
          "recommended_enabled" => FALSE,
        ],
      ],
    ];
    if ($editor = Editor::load($id)) { $editor->setSettings($settings)->save(); }
    else { Editor::create(["format" => $id, "editor" => "ckeditor5", "settings" => $settings, "image_upload" => []])->save(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ckeditor5_icons_alpha fa_styles=[solid,regular,brands]; ckeditor5_icons_beta fa_styles=[brands]"
