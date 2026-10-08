#!/usr/bin/env bash
# Introspection SETUP: create a view with a Block area handler in its header showing a known block.
set -uo pipefail
cd /var/www/html
drush php:eval '
use Drupal\views\Entity\View;
if (!View::load("vba_known")) {
  View::create(["id"=>"vba_known","label"=>"VBA Known","base_table"=>"node_field_data","base_field"=>"nid",
    "display"=>["default"=>["display_plugin"=>"default","id"=>"default","display_title"=>"Default","position"=>0,
      "display_options"=>["header"=>["views_block_area"=>[
        "id"=>"views_block_area","table"=>"views","field"=>"views_block_area","plugin_id"=>"views_block_area",
        "block_id"=>"system_powered_by_block","block_title"=>"","hide_label"=>true,"empty"=>true]]]]]])->save();
}
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view vba_known has a header Block area showing system_powered_by_block"
