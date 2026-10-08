#!/usr/bin/env bash
# Execution RESET: create a view 'vefl_region' that already uses vefl_basic + vefl_onecol but has
# the 'title' widget NOT assigned to any region, so verify FAILS until the agent assigns it to
# 'middle'. Idempotent. Exit 0.
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
\Drupal::configFactory()->getEditable("views.view.vefl_region")->setData($mk("vefl_region","VEFL Region","vefl_basic","vefl_onecol",["submit"=>"middle"]))->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view vefl_region vefl_basic, title unassigned"
