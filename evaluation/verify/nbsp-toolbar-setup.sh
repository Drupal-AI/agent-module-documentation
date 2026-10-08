#!/usr/bin/env bash
# Introspection SETUP: create a text format nbsp_tbfmt whose CKEditor 5 toolbar includes the
# NBSP button, so the agent can discover that the button is present. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if (!FilterFormat::load("nbsp_tbfmt")) {
    FilterFormat::create(["format"=>"nbsp_tbfmt","name"=>"NBSP Toolbar","filters"=>["nbsp_cleaner_filter"=>["status"=>TRUE,"weight"=>20]]])->save();
  }
  if (!Editor::load("nbsp_tbfmt")) {
    Editor::create(["format"=>"nbsp_tbfmt","editor"=>"ckeditor5","settings"=>["toolbar"=>["items"=>["bold","italic","nbsp"]]]])->save();
  }
' >/dev/null 2>&1
echo "setup: editor.editor.nbsp_tbfmt toolbar contains nbsp"
