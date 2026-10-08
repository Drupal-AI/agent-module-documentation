#!/usr/bin/env bash
# Introspection CLEANUP: restore tagclouds.settings shipped defaults. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("tagclouds.settings")->setData(["sort_order"=>"title,asc","display_type"=>"style","display_node_link"=>false,"display_more_link"=>true,"page_amount"=>"60","levels"=>6,"language_separation"=>0,"language_separation_radios"=>0])->save();' >/dev/null 2>&1
echo "cleanup: tagclouds.settings restored to defaults"
