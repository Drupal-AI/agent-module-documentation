#!/usr/bin/env bash
# Execution RESET: (re)create a CKEditor 5 format (ckeditor_bidi_h1) WITHOUT the direction
# button, so verify FAILS until the agent adds it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if (!FilterFormat::load("ckeditor_bidi_h1")) {
    FilterFormat::create(["format"=>"ckeditor_bidi_h1","name"=>"Bidi H1","weight"=>50,"filters"=>[]])->save();
  }
  $ed = Editor::load("ckeditor_bidi_h1");
  if (!$ed) { $ed = Editor::create(["format"=>"ckeditor_bidi_h1","editor"=>"ckeditor5","settings"=>[]]); }
  $ed->setSettings(["toolbar"=>["items"=>["bold","italic"]],"plugins"=>[]])->save();
' >/dev/null 2>&1
echo "reset: ckeditor_bidi_h1 present, toolbar has NO direction button"
