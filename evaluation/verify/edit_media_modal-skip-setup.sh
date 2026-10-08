#!/usr/bin/env bash
# Introspection SETUP: create emm_probe editor config with Edit Media Modal skipAccessCheck ON so
# an agent can read the live setting. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("editor.editor.emm_probe")->setData(["format"=>"emm_probe","editor"=>"ckeditor5","settings"=>["plugins"=>["media_edit_media_modal"=>["editMediaModal"=>["dialogSettings"=>["height"=>"75"],"extras"=>["skipAccessCheck"=>true],"editMediaModalForms"=>[]]]]]])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: editor.editor.emm_probe Edit Media Modal skipAccessCheck=true"
