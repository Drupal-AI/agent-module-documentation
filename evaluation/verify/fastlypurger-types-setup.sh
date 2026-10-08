#!/usr/bin/env bash
# Introspection SETUP: register the Fastly purger so an agent can inspect its supported types. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("purge.plugins")->set("purgers",[["order_index"=>1,"instance_id"=>"fastlypurger_probe","plugin_id"=>"fastly"]])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: Fastly purger registered (types tag/url/everything)"
