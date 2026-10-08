#!/usr/bin/env bash
# Execution RESET: create emm_probe editor config with Edit Media Modal height=75 so verify FAILS
# until the agent changes it to 90. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("editor.editor.emm_probe")->setData(["format"=>"emm_probe","editor"=>"ckeditor5","settings"=>["plugins"=>["media_edit_media_modal"=>["editMediaModal"=>["dialogSettings"=>["height"=>"75"],"extras"=>["skipAccessCheck"=>false],"editMediaModalForms"=>[]]]]]])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: editor.editor.emm_probe Edit Media Modal height=75"
