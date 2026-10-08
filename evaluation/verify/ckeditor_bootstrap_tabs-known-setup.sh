#!/usr/bin/env bash
# Introspection SETUP: create a namespaced text format 'ckbt_probe' with a CKEditor 5 editor whose
# toolbar includes the bootstrapTabs button, so an agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if (!FilterFormat::load("ckbt_probe")) {
    FilterFormat::create(["format"=>"ckbt_probe","name"=>"CKBT Probe","weight"=>20,"filters"=>[]])->save();
  }
  if (!Editor::load("ckbt_probe")) {
    Editor::create(["format"=>"ckbt_probe","editor"=>"ckeditor5","settings"=>["toolbar"=>["items"=>["bold","italic","bootstrapTabs"]],"plugins"=>[]]])->save();
  } else {
    $e = Editor::load("ckbt_probe"); $s = $e->getSettings();
    if (!in_array("bootstrapTabs",$s["toolbar"]["items"],TRUE)) { $s["toolbar"]["items"][]="bootstrapTabs"; $e->setSettings($s)->save(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: format ckbt_probe editor has bootstrapTabs in toolbar"
