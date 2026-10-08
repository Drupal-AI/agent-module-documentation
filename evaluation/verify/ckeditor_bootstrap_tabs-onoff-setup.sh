#!/usr/bin/env bash
# Introspection SETUP: two CKEditor 5 formats; only ckbt_on has the bootstrapTabs button.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  foreach (["ckbt_on"=>["bold","bootstrapTabs"], "ckbt_off"=>["bold","italic"]] as $fmt=>$items) {
    if (!FilterFormat::load($fmt)) { FilterFormat::create(["format"=>$fmt,"name"=>strtoupper($fmt),"weight"=>20,"filters"=>[]])->save(); }
    if (!Editor::load($fmt)) { Editor::create(["format"=>$fmt,"editor"=>"ckeditor5","settings"=>["toolbar"=>["items"=>$items],"plugins"=>[]]])->save(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ckbt_on has bootstrapTabs; ckbt_off does not"
