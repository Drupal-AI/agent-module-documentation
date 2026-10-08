#!/usr/bin/env bash
# Introspection SETUP: create nullable integer field field_vsnf_known on Article and view
# 'vsnf_known' whose default display has a views_sort_null_field null_sort (order DESC = NULL first).
# The view is written via the config factory (not the View entity) so it does not trigger unrelated
# broken views-plugin discovery on this shared site. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_vsnf_known")) { FieldStorageConfig::create(["field_name"=>"field_vsnf_known","entity_type"=>"node","type"=>"integer"])->save(); }
  if (!FieldConfig::loadByName("node","article","field_vsnf_known")) { FieldConfig::create(["field_name"=>"field_vsnf_known","entity_type"=>"node","bundle"=>"article","label"=>"VSNF Known"])->save(); }
  $data = ["langcode"=>"en","status"=>true,
    "dependencies"=>["config"=>["field.storage.node.field_vsnf_known"],"module"=>["node","user","views_sort_null_field"]],
    "id"=>"vsnf_known","label"=>"VSNF Known","module"=>"views","description"=>"","tag"=>"","base_table"=>"node_field_data","base_field"=>"nid",
    "display"=>["default"=>["id"=>"default","display_title"=>"Default","display_plugin"=>"default","position"=>0,
      "display_options"=>["title"=>"","fields"=>[],
        "pager"=>["type"=>"none","options"=>["offset"=>0]],
        "exposed_form"=>["type"=>"basic","options"=>[]],
        "access"=>["type"=>"none","options"=>[]],"cache"=>["type"=>"none","options"=>[]],
        "query"=>["type"=>"views_query","options"=>[]],"style"=>["type"=>"default","options"=>[]],"row"=>["type"=>"fields","options"=>[]],
        "sorts"=>[
          "field_vsnf_known_value_null_sort"=>["id"=>"field_vsnf_known_value_null_sort","table"=>"node__field_vsnf_known","field"=>"field_vsnf_known_value_null_sort","relationship"=>"none","group_type"=>"group","admin_label"=>"","plugin_id"=>"null_sort","order"=>"DESC","expose"=>["label"=>"","field_identifier"=>""],"exposed"=>false],
          "field_vsnf_known_value"=>["id"=>"field_vsnf_known_value","table"=>"node__field_vsnf_known","field"=>"field_vsnf_known_value","relationship"=>"none","group_type"=>"group","admin_label"=>"","plugin_id"=>"standard","order"=>"ASC","expose"=>["label"=>"","field_identifier"=>""],"exposed"=>false],
        ],
      ]]]];
  \Drupal::configFactory()->getEditable("views.view.vsnf_known")->setData($data)->save();
' >/dev/null 2>&1
echo "setup: view vsnf_known has null_sort (order DESC) on field_vsnf_known_value_null_sort"
