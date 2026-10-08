#!/usr/bin/env bash
# Execution RESET: create view 'vefl_bef_task' using the plain 'basic' exposed form, so verify
# FAILS until the agent switches it to the vefl_bef style with vefl_onecol. Idempotent. Exit 0.
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
            : ["submit_button"=>"Apply","reset_button"=>false,"bef"=>[],"layout"=>["layout_id"=>$layout_id,"regions"=>[],"widget_region"=>$widget_region]],
        ],
        "pager"=>["type"=>"mini"],
      ],
    ]],
  ];
};
\Drupal::configFactory()->getEditable("views.view.vefl_bef_task")->setData($mk("vefl_bef_task","VEFL BEF Task","basic","",[]))->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view vefl_bef_task exposed_form type=basic"
