#!/usr/bin/env bash
# Introspection SETUP: limit the login requirement to /reports paths via the request_path condition.
set -uo pipefail
cd /var/www/html
drush php:eval '$c = \Drupal::configFactory()->getEditable("require_login.settings"); $c->set("requirements",["request_path"=>["id"=>"request_path","negate"=>FALSE,"pages"=>"/reports\n/reports/*"]])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: request_path pages limited to /reports and /reports/*"
