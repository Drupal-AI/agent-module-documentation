#!/usr/bin/env bash
# Execution RESET: create/replace CKEditor 5 text format ckq_task WITHOUT the Quote button, so
# verify FAILS until the agent adds it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if (!FilterFormat::load("ckq_task")) {
    FilterFormat::create(["format"=>"ckq_task","name"=>"CKQ Task","weight"=>50,"filters"=>[]])->save();
  }
  if ($e = Editor::load("ckq_task")) { $e->delete(); }
  Editor::create([
    "format"=>"ckq_task","editor"=>"ckeditor5",
    "settings"=>["toolbar"=>["items"=>["bold","italic"]],"plugins"=>[]],
    "image_upload"=>[],
  ])->save();
' >/dev/null 2>&1
echo "reset: ckq_task present WITHOUT Quote button"
