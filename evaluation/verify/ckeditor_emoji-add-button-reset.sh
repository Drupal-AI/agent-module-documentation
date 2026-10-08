#!/usr/bin/env bash
# Execution RESET: ensure a CKEditor 5 format 'ckemoji_task' exists with the Emoji button ABSENT
# from its toolbar (so verify FAILS until the agent adds it). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if (!FilterFormat::load("ckemoji_task")) {
    FilterFormat::create(["format"=>"ckemoji_task","name"=>"CKEmoji Task","weight"=>20,"filters"=>[]])->save();
  }
  $e = Editor::load("ckemoji_task");
  if (!$e) {
    $e = Editor::create(["format"=>"ckemoji_task","editor"=>"ckeditor5","settings"=>["toolbar"=>["items"=>[]],"plugins"=>[]]]);
  }
  $s = $e->getSettings();
  $s["toolbar"]["items"] = array_values(array_filter(["bold","italic"], fn($i)=>$i!=="Emoji"));
  $e->setSettings($s)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: ckemoji_task present (CKEditor 5), Emoji button NOT in toolbar"
