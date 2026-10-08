#!/usr/bin/env bash
# Execution RESET: restore securelogin.settings forms to the shipped default (which does NOT
# include node_form) and clear other_forms, so verify FAILS until the agent secures node forms.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("securelogin.settings")->set("forms",["user_login_form","user_form","user_register_form","user_pass_reset","user_pass"])->set("other_forms",[])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: securelogin forms=default (node_form absent), other_forms=[]"
