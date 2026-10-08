#!/usr/bin/env bash
# Execution RESET (sort): create a moderated content type vmsw_stype (workflow vmsw_sflow) and a
# base view vmsw_sview of content WITHOUT any moderation-state-weight sort, so verify FAILS until
# the agent adds the sort. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\workflows\Entity\Workflow;
  use Drupal\views\Entity\View;
  if (!NodeType::load("vmsw_stype")) { NodeType::create(["type"=>"vmsw_stype","name"=>"VMSW Sort Type"])->save(); }
  $w = Workflow::load("vmsw_sflow") ?: Workflow::create(["id"=>"vmsw_sflow","label"=>"VMSW Sort Flow","type"=>"content_moderation"]);
  $tp = $w->getTypePlugin(); $conf = $tp->getConfiguration();
  $conf["entity_types"]["node"] = ["vmsw_stype"];
  $tp->setConfiguration($conf); $w->save();
  if ($v = View::load("vmsw_sview")) { $v->delete(); }
  View::create([
    "id"=>"vmsw_sview","label"=>"VMSW Sort View","base_table"=>"node_field_data","base_field"=>"nid",
    "display"=>["default"=>["display_plugin"=>"default","id"=>"default","display_title"=>"Default","position"=>0,
      "display_options"=>["fields"=>[],"sorts"=>[]]]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: vmsw_stype moderated, base view vmsw_sview has no weight sort"
