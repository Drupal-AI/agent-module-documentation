#!/usr/bin/env bash
# Introspection SETUP: create a view with a Block field handler showing a known block.
set -uo pipefail
cd /var/www/html
drush php:eval '
use Drupal\views\Entity\View;
if (!View::load("vba_fld")) {
  View::create(["id"=>"vba_fld","label"=>"VBA Field","base_table"=>"node_field_data","base_field"=>"nid",
    "display"=>["default"=>["display_plugin"=>"default","id"=>"default","display_title"=>"Default","position"=>0,
      "display_options"=>["fields"=>["views_block_field"=>[
        "id"=>"views_block_field","table"=>"views","field"=>"views_block_field","plugin_id"=>"views_block_field",
        "block_id"=>"system_branding_block","block_title"=>"","hide_label"=>true,"empty"=>false]]]]]])->save();
}
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view vba_fld has a Block field showing system_branding_block"
