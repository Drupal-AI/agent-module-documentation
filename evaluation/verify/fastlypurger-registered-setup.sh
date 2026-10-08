#!/usr/bin/env bash
# Introspection SETUP: register the Fastly purger in the Purge module so an agent can inspect it. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("purge.plugins")->set("purgers",[["order_index"=>1,"instance_id"=>"fastlypurger_probe","plugin_id"=>"fastly"]])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: purge.plugins purgers has plugin_id fastly (instance fastlypurger_probe)"
