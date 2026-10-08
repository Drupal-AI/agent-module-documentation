#!/usr/bin/env bash
# Introspection SETUP: create a text format crt_medium whose CKEditor 5 toolbar includes the
# Responsive Table button (customTable), so the agent can report which format has it enabled.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  use Drupal\editor\Entity\Editor;
  if (!FilterFormat::load("crt_medium")) {
    FilterFormat::create(["format"=>"crt_medium","name"=>"CRT Medium","filters"=>[]])->save();
  }
  if (!Editor::load("crt_medium")) {
    Editor::create(["format"=>"crt_medium","editor"=>"ckeditor5",
      "settings"=>["toolbar"=>["items"=>["bold","italic","customTable"]],"plugins"=>[]]])->save();
  }
' >/dev/null 2>&1
echo "setup: text format crt_medium has customTable in its CKEditor 5 toolbar"
