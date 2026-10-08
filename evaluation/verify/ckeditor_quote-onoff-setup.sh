#!/usr/bin/env bash
# Introspection SETUP: two CKEditor 5 formats: ckq_on has the Quote button, ckq_off does not.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  foreach (["ckq_on"=>["bold","Quote"], "ckq_off"=>["bold","italic"]] as $fmt=>$items) {
    if (!FilterFormat::load($fmt)) {
      FilterFormat::create(["format"=>$fmt,"name"=>strtoupper($fmt),"weight"=>50,"filters"=>[]])->save();
    }
    if ($e = Editor::load($fmt)) { $e->delete(); }
    Editor::create([
      "format"=>$fmt,"editor"=>"ckeditor5",
      "settings"=>["toolbar"=>["items"=>$items],"plugins"=>[]],
      "image_upload"=>[],
    ])->save();
  }
' >/dev/null 2>&1
echo "setup: ckq_on has Quote button; ckq_off does not"
