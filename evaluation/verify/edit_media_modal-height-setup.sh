#!/usr/bin/env bash
# Introspection SETUP: create a CKEditor 5 text-format editor config (emm_probe) whose Edit Media
# Modal plugin has a distinctive dialog height so an agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("editor.editor.emm_probe")->setData(["format"=>"emm_probe","editor"=>"ckeditor5","settings"=>["plugins"=>["media_edit_media_modal"=>["editMediaModal"=>["dialogSettings"=>["height"=>"60"],"extras"=>["skipAccessCheck"=>false],"editMediaModalForms"=>[]]]]]])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: editor.editor.emm_probe Edit Media Modal height=60"
