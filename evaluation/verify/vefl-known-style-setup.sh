#!/usr/bin/env bash
# Introspection SETUP: create a view 'vefl_known2' whose exposed form style is vefl_basic with
# the vefl_onecol layout. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
$mk = function($id,$label,$eftype,$layout_id,$widget_region){
  return [
    "langcode"=>"en","status"=>true,
    "dependencies"=>["module"=>["node","user","views"]],
    "id"=>$id,"label"=>$label,"module"=>"views","description"=>"",
    "tag"=>"","base_table"=>"node_field_data","base_field"=>"nid",
    "display"=>["default"=>[
      "id"=>"default","display_title"=>"Default","display_plugin"=>"default","position"=>0,
      "display_options"=>[
        "title"=>$label,
        "exposed_form"=>[
          "type"=>$eftype,
          "options"=> ($eftype==="basic")
            ? ["submit_button"=>"Apply","reset_button"=>false]
            : ["submit_button"=>"Apply","reset_button"=>false,"layout"=>["layout_id"=>$layout_id,"regions"=>[],"widget_region"=>$widget_region]],
        ],
        "pager"=>["type"=>"mini"],
      ],
    ]],
  ];
};
\Drupal::configFactory()->getEditable("views.view.vefl_known2")->setData($mk("vefl_known2","VEFL Known2","vefl_basic","vefl_onecol",["title"=>"middle"]))->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view vefl_known2 exposed_form vefl_basic layout vefl_onecol"
