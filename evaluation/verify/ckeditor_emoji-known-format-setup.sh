#!/usr/bin/env bash
# Introspection SETUP: create a CKEditor 5 text format 'ckemoji_known' whose toolbar includes the
# ckeditor_emoji 'Emoji' button, so an inspecting agent can read back which format has emoji on.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if (!FilterFormat::load("ckemoji_known")) {
    FilterFormat::create(["format"=>"ckemoji_known","name"=>"CKEmoji Known","weight"=>20,"filters"=>[]])->save();
  }
  if (!Editor::load("ckemoji_known")) {
    Editor::create(["format"=>"ckemoji_known","editor"=>"ckeditor5",
      "settings"=>["toolbar"=>["items"=>["bold","italic","Emoji"]],"plugins"=>[]]])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: text format ckemoji_known has the Emoji button in its CKEditor 5 toolbar"
