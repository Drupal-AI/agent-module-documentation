#!/usr/bin/env bash
# Execution RESET (field): create a moderated content type vmsw_ftype (workflow vmsw_fflow) and a
# base view vmsw_fview WITHOUT a moderation-state-weight field, so verify FAILS until the agent
# adds the field. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\workflows\Entity\Workflow;
  use Drupal\views\Entity\View;
  if (!NodeType::load("vmsw_ftype")) { NodeType::create(["type"=>"vmsw_ftype","name"=>"VMSW Field Type"])->save(); }
  $w = Workflow::load("vmsw_fflow") ?: Workflow::create(["id"=>"vmsw_fflow","label"=>"VMSW Field Flow","type"=>"content_moderation"]);
  $tp = $w->getTypePlugin(); $conf = $tp->getConfiguration();
  $conf["entity_types"]["node"] = ["vmsw_ftype"];
  $tp->setConfiguration($conf); $w->save();
  if ($v = View::load("vmsw_fview")) { $v->delete(); }
  View::create([
    "id"=>"vmsw_fview","label"=>"VMSW Field View","base_table"=>"node_field_data","base_field"=>"nid",
    "display"=>["default"=>["display_plugin"=>"default","id"=>"default","display_title"=>"Default","position"=>0,
      "display_options"=>["fields"=>[],"sorts"=>[]]]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: vmsw_ftype moderated, base view vmsw_fview has no weight field"
