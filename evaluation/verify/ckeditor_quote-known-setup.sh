#!/usr/bin/env bash
# Introspection SETUP: create a CKEditor 5 text format ckq_known whose toolbar includes the
# ckeditor_quote "Quote" button. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if (!FilterFormat::load("ckq_known")) {
    FilterFormat::create(["format"=>"ckq_known","name"=>"CKQ Known","weight"=>50,"filters"=>[]])->save();
  }
  if ($e = Editor::load("ckq_known")) { $e->delete(); }
  Editor::create([
    "format"=>"ckq_known","editor"=>"ckeditor5",
    "settings"=>["toolbar"=>["items"=>["bold","italic","Quote"]],"plugins"=>[]],
    "image_upload"=>[],
  ])->save();
' >/dev/null 2>&1
echo "setup: text format ckq_known has CKEditor 5 Quote button in toolbar"
