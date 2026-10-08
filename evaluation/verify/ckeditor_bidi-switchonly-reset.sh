#!/usr/bin/env bash
# Execution RESET: (re)create a CKEditor 5 format (ckeditor_bidi_h2) that HAS the direction
# button but with switch_only=FALSE, so verify FAILS until the agent enables switch_only.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if (!FilterFormat::load("ckeditor_bidi_h2")) {
    FilterFormat::create(["format"=>"ckeditor_bidi_h2","name"=>"Bidi H2","weight"=>50,"filters"=>[]])->save();
  }
  $ed = Editor::load("ckeditor_bidi_h2");
  if (!$ed) { $ed = Editor::create(["format"=>"ckeditor_bidi_h2","editor"=>"ckeditor5","settings"=>[]]); }
  $ed->setSettings(["toolbar"=>["items"=>["bold","direction"]],"plugins"=>["ckeditor_bidi_ckeditor5"=>["switch_only"=>FALSE]]])->save();
' >/dev/null 2>&1
echo "reset: ckeditor_bidi_h2 has direction button, switch_only=FALSE"
