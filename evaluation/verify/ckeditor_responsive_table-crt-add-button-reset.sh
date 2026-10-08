#!/usr/bin/env bash
# Execution RESET: (re)create text format crt_hard with a CKEditor 5 toolbar that does NOT
# include customTable, so verify FAILS until the agent adds the Responsive Table button.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if (!FilterFormat::load("crt_hard")) {
    FilterFormat::create(["format"=>"crt_hard","name"=>"CRT Hard","filters"=>[]])->save();
  }
  if ($e = Editor::load("crt_hard")) { $e->delete(); }
  Editor::create(["format"=>"crt_hard","editor"=>"ckeditor5",
    "settings"=>["toolbar"=>["items"=>["bold","italic"]],"plugins"=>[]]])->save();
' >/dev/null 2>&1
echo "reset: crt_hard editor present WITHOUT customTable"
