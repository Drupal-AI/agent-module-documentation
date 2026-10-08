#!/usr/bin/env bash
# Execution RESET: (re)create format nbsp_tb + a CKEditor 5 editor whose toolbar does NOT
# contain the nbsp button, so verify FAILS until the agent adds it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if ($e = Editor::load("nbsp_tb")) { $e->delete(); }
  if ($f = FilterFormat::load("nbsp_tb")) { $f->delete(); }
  FilterFormat::create(["format"=>"nbsp_tb","name"=>"NBSP Button","filters"=>["nbsp_cleaner_filter"=>["status"=>TRUE,"weight"=>20]]])->save();
  Editor::create(["format"=>"nbsp_tb","editor"=>"ckeditor5","settings"=>["toolbar"=>["items"=>["bold","italic"]]]])->save();
' >/dev/null 2>&1
echo "reset: editor.editor.nbsp_tb toolbar has no nbsp button"
