#!/usr/bin/env bash
# Introspection SETUP: create a namespaced CKEditor 5 text format (ckeditor_bidi_m1) whose
# toolbar includes the BiDi 'direction' button, so an inspecting agent can find which format
# has it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if (!FilterFormat::load("ckeditor_bidi_m1")) {
    FilterFormat::create(["format"=>"ckeditor_bidi_m1","name"=>"Bidi M1","weight"=>50,"filters"=>[]])->save();
  }
  if (!Editor::load("ckeditor_bidi_m1")) {
    Editor::create(["format"=>"ckeditor_bidi_m1","editor"=>"ckeditor5",
      "settings"=>["toolbar"=>["items"=>["bold","direction"]],"plugins"=>["ckeditor_bidi_ckeditor5"=>["switch_only"=>FALSE]]]])->save();
  }
' >/dev/null 2>&1
echo "setup: text format ckeditor_bidi_m1 has the direction button in its CKEditor5 toolbar"
