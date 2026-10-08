#!/usr/bin/env bash
# Introspection SETUP: add a Field Group 'Table' group (group_fgt_known) to the Article default
# view display so an agent can inspect the display config and report its group format type. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $d = \Drupal::service("entity_display.repository")->getViewDisplay("node","article","default");
  $d->setThirdPartySetting("field_group","group_fgt_known",[
    "children"=>[],"parent_name"=>"","weight"=>10,"region"=>"content","label"=>"FGT Known",
    "format_type"=>"field_group_table",
    "format_settings"=>["first_column"=>"Property","second_column"=>""],
  ]);
  $d->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article default view display has group_fgt_known (format_type field_group_table)"
