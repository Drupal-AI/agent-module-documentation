#!/usr/bin/env bash
# Execution RESET: ensure field_vsnf_taskb on Article and view 'vsnf_taskb' exist with ONLY a plain
# field sort (NO null_sort), via the config factory. verify FAILs until the agent adds a null_sort
# DESC (NULL first). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_vsnf_taskb")) { FieldStorageConfig::create(["field_name"=>"field_vsnf_taskb","entity_type"=>"node","type"=>"integer"])->save(); }
  if (!FieldConfig::loadByName("node","article","field_vsnf_taskb")) { FieldConfig::create(["field_name"=>"field_vsnf_taskb","entity_type"=>"node","bundle"=>"article","label"=>"VSNF Task B"])->save(); }
  $data = ["langcode"=>"en","status"=>true,
    "dependencies"=>["config"=>["field.storage.node.field_vsnf_taskb"],"module"=>["node","user"]],
    "id"=>"vsnf_taskb","label"=>"VSNF Task B","module"=>"views","description"=>"","tag"=>"","base_table"=>"node_field_data","base_field"=>"nid",
    "display"=>["default"=>["id"=>"default","display_title"=>"Default","display_plugin"=>"default","position"=>0,
      "display_options"=>["title"=>"","fields"=>[],
        "pager"=>["type"=>"none","options"=>["offset"=>0]],
        "exposed_form"=>["type"=>"basic","options"=>[]],
        "access"=>["type"=>"none","options"=>[]],"cache"=>["type"=>"none","options"=>[]],
        "query"=>["type"=>"views_query","options"=>[]],"style"=>["type"=>"default","options"=>[]],"row"=>["type"=>"fields","options"=>[]],
        "sorts"=>[
          "field_vsnf_taskb_value"=>["id"=>"field_vsnf_taskb_value","table"=>"node__field_vsnf_taskb","field"=>"field_vsnf_taskb_value","relationship"=>"none","group_type"=>"group","admin_label"=>"","plugin_id"=>"standard","order"=>"ASC","expose"=>["label"=>"","field_identifier"=>""],"exposed"=>false],
        ],
      ]]]];
  \Drupal::configFactory()->getEditable("views.view.vsnf_taskb")->setData($data)->save();
' >/dev/null 2>&1
echo "reset: view vsnf_taskb present with a plain sort and NO null_sort"
