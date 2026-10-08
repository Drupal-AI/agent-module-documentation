#!/usr/bin/env bash
# Introspection SETUP: map the 'vip' user form mode to auto-assign roles fmra_vip and fmra_gold. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("form_mode_user_roles_assign.settings")->set("form_modes.user_vip.assign_roles",["fmra_vip"=>"fmra_vip","fmra_gold"=>"fmra_gold"])->save();' >/dev/null 2>&1
echo "setup: form_modes.user_vip.assign_roles = [fmra_vip, fmra_gold]"
