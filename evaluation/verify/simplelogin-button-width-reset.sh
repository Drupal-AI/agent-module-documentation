#!/usr/bin/env bash
# Execution RESET: restore simplelogin.settings defaults (button_background false, width 360) so
# verify FAILS until the agent turns on button colors and widens the card. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("simplelogin.settings")->setData(["background_active"=>false,"background_image"=>[],"background_color"=>"#00bfff","background_opacity"=>false,"button_background"=>false,"wrapper_width"=>360,"unset_active_css"=>false,"unset_css"=>"","visually_hidden_labels"=>true])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: simplelogin.settings at defaults"
