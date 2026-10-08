#!/usr/bin/env bash
# Introspection SETUP: map the 'partner' user form mode to auto-assign role fmra_partner. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("form_mode_user_roles_assign.settings")->set("form_modes.user_partner.assign_roles",["fmra_partner"=>"fmra_partner"])->save();' >/dev/null 2>&1
echo "setup: form_modes.user_partner.assign_roles = [fmra_partner]"
