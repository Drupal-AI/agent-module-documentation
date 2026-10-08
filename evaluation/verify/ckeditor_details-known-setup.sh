#!/usr/bin/env bash
# Introspection SETUP: create a CKEditor 5 text format ckd_known whose toolbar includes the
# ckeditor_details accordion button ('detail'), so an agent can read back which format has it. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if (!FilterFormat::load("ckd_known")) { FilterFormat::create(["format"=>"ckd_known","name"=>"CKD Known","weight"=>20,"filters"=>[]])->save(); }
  $ed = Editor::load("ckd_known") ?: Editor::create(["format"=>"ckd_known","editor"=>"ckeditor5"]);
  $ed->setSettings(["toolbar"=>["items"=>["bold","italic","detail"]],"plugins"=>[]]);
  $ed->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: CKEditor5 format ckd_known has the accordion 'detail' toolbar button"
