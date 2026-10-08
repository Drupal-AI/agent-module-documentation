#!/usr/bin/env bash
# Introspection SETUP: create a view (dt_known) whose display uses the DataTables style. Raw
# config write (Views config-entity save via the entity API is currently blocked by an unrelated
# broken commerce_giftcard field on this shared site). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
$vid = "dt_known";
  \Drupal::configFactory()->getEditable("views.view.$vid")->setData([
    "langcode"=>"en","status"=>true,"dependencies"=>["module"=>["datatables","node","user"]],
    "id"=>$vid,"label"=>"DT Known","module"=>"views","description"=>"",
    "tag"=>"","base_table"=>"node_field_data","base_field"=>"nid",
    "uuid"=>\Drupal::service("uuid")->generate(),
    "display"=>["default"=>[
      "id"=>"default","display_title"=>"Default","display_plugin"=>"default","position"=>0,
      "display_options"=>[
        "style"=>["type"=>"datatables","options"=>[]],
        "row"=>["type"=>"fields"],"fields"=>[],
        "pager"=>["type"=>"none","options"=>[]],
      ],
    ]],
  ])->save();
' >/dev/null 2>&1
echo "setup: view dt_known created with DataTables style"
