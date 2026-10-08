#!/usr/bin/env bash
# Execution RESET: create format 'ckbt_task2' with a CKEditor 5 editor WITHOUT the bootstrapTabs
# button (so verify FAILS until the agent adds it). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if (!FilterFormat::load("ckbt_task2")) { FilterFormat::create(["format"=>"ckbt_task2","name"=>"CKBT Task2","weight"=>20,"filters"=>[]])->save(); }
  if ($e = Editor::load("ckbt_task2")) { $e->delete(); }
  Editor::create(["format"=>"ckbt_task2","editor"=>"ckeditor5","settings"=>["toolbar"=>["items"=>["bold","italic"]],"plugins"=>[]]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: format ckbt_task2 editor toolbar has NO bootstrapTabs"
