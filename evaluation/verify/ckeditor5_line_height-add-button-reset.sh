#!/usr/bin/env bash
# Execution RESET: ensure a CKEditor 5 format 'clh_task' exists WITHOUT the Line Height button
# (so verify FAILS until the agent adds it). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if (!FilterFormat::load("clh_task")) { FilterFormat::create(["format" => "clh_task", "name" => "CLH Task", "filters" => []])->save(); }
  $ed = Editor::load("clh_task") ?: Editor::create(["format" => "clh_task", "editor" => "ckeditor5"]);
  $ed->setSettings(["toolbar" => ["items" => ["bold", "italic"]], "plugins" => []])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: clh_task present, toolbar WITHOUT lineHeight"
