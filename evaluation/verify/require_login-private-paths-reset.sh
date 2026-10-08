#!/usr/bin/env bash
# Execution RESET: restore shipped defaults (request_path pages empty) so verify FAILS.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\Core\Config\Config; $c = \Drupal::configFactory()->getEditable("require_login.settings"); $c->set("login_path","")->set("login_message","")->set("login_destination","")->set("requirements",["request_path"=>["id"=>"request_path","negate"=>FALSE,"pages"=>""]])->set("extra",["include_403"=>FALSE,"include_404"=>FALSE])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: require_login.settings at shipped defaults"
