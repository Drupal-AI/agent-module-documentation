#!/usr/bin/env bash
# Introspection SETUP: create a CKEditor5 text format eai_hidden whose Editor Advanced Image
# plugin has disable_balloon = TRUE, so an inspecting agent can read that the balloon button is
# disabled on that format. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if (!FilterFormat::load("eai_hidden")) {
    FilterFormat::create(["format"=>"eai_hidden","name"=>"EAI Hidden","filters"=>[]])->save();
  }
  $e = Editor::load("eai_hidden") ?: Editor::create(["format"=>"eai_hidden","editor"=>"ckeditor5"]);
  $s = $e->getSettings();
  $s["toolbar"]["items"] = $s["toolbar"]["items"] ?? [];
  $s["plugins"]["editor_advanced_image_image"] = [
    "disable_balloon" => TRUE,
    "default_class" => "",
    "enabled_attributes" => ["class"],
  ];
  $e->setSettings($s);
  if ($e->isNew()) { $e->set("image_upload", []); }
  $e->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: editor.editor.eai_hidden editor_advanced_image_image disable_balloon=TRUE"
