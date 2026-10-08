#!/usr/bin/env bash
# Execution RESET: ensure CKEditor5 format eai_dbtask exists with Editor Advanced Image and
# disable_balloon FALSE, so verify FAILS until the agent disables the balloon. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if (!FilterFormat::load("eai_dbtask")) {
    FilterFormat::create(["format"=>"eai_dbtask","name"=>"EAI DB Task","filters"=>[]])->save();
  }
  $e = Editor::load("eai_dbtask") ?: Editor::create(["format"=>"eai_dbtask","editor"=>"ckeditor5"]);
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
echo "reset: eai_dbtask present with disable_balloon=FALSE"
