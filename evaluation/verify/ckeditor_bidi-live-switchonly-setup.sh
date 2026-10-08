#!/usr/bin/env bash
# Introspection SETUP: create a namespaced CKEditor 5 format (ckeditor_bidi_m2) with the BiDi
# button AND switch_only enabled, so an inspecting agent can read the switch_only value.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if (!FilterFormat::load("ckeditor_bidi_m2")) {
    FilterFormat::create(["format"=>"ckeditor_bidi_m2","name"=>"Bidi M2","weight"=>50,"filters"=>[]])->save();
  }
  $ed = Editor::load("ckeditor_bidi_m2");
  if (!$ed) { $ed = Editor::create(["format"=>"ckeditor_bidi_m2","editor"=>"ckeditor5","settings"=>[]]); }
  $ed->setSettings(["toolbar"=>["items"=>["bold","direction"]],"plugins"=>["ckeditor_bidi_ckeditor5"=>["switch_only"=>TRUE]]])->save();
' >/dev/null 2>&1
echo "setup: ckeditor_bidi_m2 has switch_only=true on the BiDi plugin"
