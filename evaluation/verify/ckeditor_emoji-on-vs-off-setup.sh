#!/usr/bin/env bash
# Introspection SETUP: two CKEditor 5 formats — ckemoji_on has the Emoji button, ckemoji_off does
# not — so an agent must read the live editor config to tell which one has emoji enabled.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  foreach (["ckemoji_on"=>["bold","italic","Emoji"], "ckemoji_off"=>["bold","italic"]] as $id=>$items) {
    if (!FilterFormat::load($id)) {
      FilterFormat::create(["format"=>$id,"name"=>strtoupper($id),"weight"=>20,"filters"=>[]])->save();
    }
    if (!Editor::load($id)) {
      Editor::create(["format"=>$id,"editor"=>"ckeditor5","settings"=>["toolbar"=>["items"=>$items],"plugins"=>[]]])->save();
    }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ckemoji_on has Emoji button, ckemoji_off does not"
