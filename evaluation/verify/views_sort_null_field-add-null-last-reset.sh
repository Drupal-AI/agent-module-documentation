#!/usr/bin/env bash
# Execution RESET: ensure field_vsnf_task on Article and view 'vsnf_task' exist with ONLY a plain
# ascending field sort (NO null_sort), written via the config factory (avoids unrelated broken
# views-plugin discovery on this shared site). verify FAILs until the agent adds a null_sort ASC.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_vsnf_task")) { FieldStorageConfig::create(["field_name"=>"field_vsnf_task","entity_type"=>"node","type"=>"integer"])->save(); }
  if (!FieldConfig::loadByName("node","article","field_vsnf_task")) { FieldConfig::create(["field_name"=>"field_vsnf_task","entity_type"=>"node","bundle"=>"article","label"=>"VSNF Task"])->save(); }
  $data = ["langcode"=>"en","status"=>true,
    "dependencies"=>["config"=>["field.storage.node.field_vsnf_task"],"module"=>["node","user"]],
    "id"=>"vsnf_task","label"=>"VSNF Task","module"=>"views","description"=>"","tag"=>"","base_table"=>"node_field_data","base_field"=>"nid",
    "display"=>["default"=>["id"=>"default","display_title"=>"Default","display_plugin"=>"default","position"=>0,
      "display_options"=>["title"=>"","fields"=>[],
        "pager"=>["type"=>"none","options"=>["offset"=>0]],
        "exposed_form"=>["type"=>"basic","options"=>[]],
        "access"=>["type"=>"none","options"=>[]],"cache"=>["type"=>"none","options"=>[]],
        "query"=>["type"=>"views_query","options"=>[]],"style"=>["type"=>"default","options"=>[]],"row"=>["type"=>"fields","options"=>[]],
        "sorts"=>[
          "field_vsnf_task_value"=>["id"=>"field_vsnf_task_value","table"=>"node__field_vsnf_task","field"=>"field_vsnf_task_value","relationship"=>"none","group_type"=>"group","admin_label"=>"","plugin_id"=>"standard","order"=>"ASC","expose"=>["label"=>"","field_identifier"=>""],"exposed"=>false],
        ],
      ]]]];
  \Drupal::configFactory()->getEditable("views.view.vsnf_task")->setData($data)->save();
' >/dev/null 2>&1
echo "reset: view vsnf_task present with a plain ASC sort and NO null_sort"
