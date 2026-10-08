#!/usr/bin/env bash
# Execution RESET: ensure CKEditor5 format eai_task exists with Editor Advanced Image at its
# DEFAULT config (enabled_attributes [class], default_class "", disable_balloon FALSE) so verify
# FAILS until the agent enables the title+id attributes and sets a default class. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if (!FilterFormat::load("eai_task")) {
    FilterFormat::create(["format"=>"eai_task","name"=>"EAI Task","filters"=>[]])->save();
  }
  $e = Editor::load("eai_task") ?: Editor::create(["format"=>"eai_task","editor"=>"ckeditor5"]);
  $s = $e->getSettings();
  $s["toolbar"]["items"] = $s["toolbar"]["items"] ?? [];
  $s["plugins"]["editor_advanced_image_image"] = [
    "disable_balloon" => FALSE,
    "default_class" => "",
    "enabled_attributes" => ["class"],
  ];
  $e->setSettings($s);
  if ($e->isNew()) { $e->set("image_upload", []); }
  $e->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: eai_task present with default editor_advanced_image_image config"
