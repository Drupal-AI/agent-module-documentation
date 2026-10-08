#!/usr/bin/env bash
# Execution RESET: ensure CKEditor5 format ckd_task exists WITHOUT the 'detail' button, so verify FAILS
# until the agent adds the accordion button to its toolbar. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if (!FilterFormat::load("ckd_task")) { FilterFormat::create(["format"=>"ckd_task","name"=>"CKD Task","weight"=>23,"filters"=>[]])->save(); }
  $ed = Editor::load("ckd_task") ?: Editor::create(["format"=>"ckd_task","editor"=>"ckeditor5"]);
  $ed->setSettings(["toolbar"=>["items"=>["bold","italic","link"]],"plugins"=>[]]); $ed->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: CKEditor5 format ckd_task exists WITHOUT 'detail' in toolbar"
