#!/usr/bin/env bash
# Introspection SETUP: add a Table field group (group_fgt_hdr) with a known second-column header
# so an agent can read the format setting back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $d = \Drupal::service("entity_display.repository")->getViewDisplay("node","article","default");
  $d->setThirdPartySetting("field_group","group_fgt_hdr",[
    "children"=>[],"parent_name"=>"","weight"=>11,"region"=>"content","label"=>"FGT Hdr",
    "format_type"=>"field_group_table",
    "format_settings"=>["first_column"=>"Attribute","second_column"=>"Reading","table_row_striping"=>TRUE],
  ]);
  $d->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: group_fgt_hdr second_column header = Reading"
