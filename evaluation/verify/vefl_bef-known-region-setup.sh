#!/usr/bin/env bash
# Introspection SETUP: create a view 'vefl_bef_region' (vefl_bef style) placing the 'title'
# widget in the 'middle' region. Idempotent. Exit 0.
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
          "options"=> in_array($eftype,["basic","vefl_basic"],true) && $eftype==="basic"
            ? ["submit_button"=>"Apply","reset_button"=>false]
            : ["submit_button"=>"Apply","reset_button"=>false,"bef"=>[],"layout"=>["layout_id"=>$layout_id,"regions"=>[],"widget_region"=>$widget_region]],
        ],
        "pager"=>["type"=>"mini"],
      ],
    ]],
  ];
};
\Drupal::configFactory()->getEditable("views.view.vefl_bef_region")->setData($mk("vefl_bef_region","VEFL BEF Region","vefl_bef","vefl_onecol",["title"=>"middle","submit"=>"middle"]))->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view vefl_bef_region title -> region middle"
