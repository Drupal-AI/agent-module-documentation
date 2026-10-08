#!/usr/bin/env bash
# Introspection SETUP: create CKEditor5 formats ckd_on (toolbar has 'detail') and ckd_off (no 'detail'),
# so an agent can tell which format has the accordion button. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if (!FilterFormat::load("ckd_on")) { FilterFormat::create(["format"=>"ckd_on","name"=>"CKD On","weight"=>21,"filters"=>[]])->save(); }
  $on = Editor::load("ckd_on") ?: Editor::create(["format"=>"ckd_on","editor"=>"ckeditor5"]);
  $on->setSettings(["toolbar"=>["items"=>["bold","detail","italic"]],"plugins"=>[]]); $on->save();
  if (!FilterFormat::load("ckd_off")) { FilterFormat::create(["format"=>"ckd_off","name"=>"CKD Off","weight"=>22,"filters"=>[]])->save(); }
  $off = Editor::load("ckd_off") ?: Editor::create(["format"=>"ckd_off","editor"=>"ckeditor5"]);
  $off->setSettings(["toolbar"=>["items"=>["bold","italic","link"]],"plugins"=>[]]); $off->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ckd_on has 'detail' button; ckd_off does not"
