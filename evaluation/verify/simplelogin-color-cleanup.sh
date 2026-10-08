#!/usr/bin/env bash
# Introspection CLEANUP: restore simplelogin.settings shipped defaults. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("simplelogin.settings")->setData(["background_active"=>false,"background_image"=>[],"background_color"=>"#00bfff","background_opacity"=>false,"button_background"=>false,"wrapper_width"=>360,"unset_active_css"=>false,"unset_css"=>"","visually_hidden_labels"=>true])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: simplelogin.settings restored to defaults"
