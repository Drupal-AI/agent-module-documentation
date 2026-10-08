#!/usr/bin/env bash
# Introspection SETUP: create a CKEditor5 text format eai_known whose Editor Advanced Image
# plugin has enabled_attributes [class,title] and default_class "teaser-img", so an inspecting
# agent can read the live editor.editor.eai_known config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if (!FilterFormat::load("eai_known")) {
    FilterFormat::create(["format"=>"eai_known","name"=>"EAI Known","filters"=>[]])->save();
  }
  $e = Editor::load("eai_known") ?: Editor::create(["format"=>"eai_known","editor"=>"ckeditor5"]);
  $s = $e->getSettings();
  $s["toolbar"]["items"] = $s["toolbar"]["items"] ?? [];
  $s["plugins"]["editor_advanced_image_image"] = [
    "disable_balloon" => FALSE,
    "default_class" => "teaser-img",
    "enabled_attributes" => ["class", "title"],
  ];
  $e->setSettings($s);
  if ($e->isNew()) { $e->set("image_upload", []); }
  $e->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: editor.editor.eai_known editor_advanced_image_image enabled_attributes=[class,title] default_class=teaser-img"
