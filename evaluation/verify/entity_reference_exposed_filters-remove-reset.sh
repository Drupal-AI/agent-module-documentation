#!/usr/bin/env bash
# Execution RESET (remove case): create a View eref_eval whose default display uses the
# eref_node_titles filter, so the agent can remove it and verify FAILS until they do. Idempotent.
# The filtered fixture view is written as raw config (see entity_reference_exposed_filters-view-setup.sh
# for why): entity-save's Views filter-plugin discovery pass fatals on shared sites that also host
# a contrib views filter with an incompatible method signature. The agent's removal (load the view,
# drop the filter, save a view that ends with no filters) does not hit that pass, so the execution
# task is still exercised normally.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("eref_eval")) { $v->delete(); }
  $data = [
    "langcode"=>"en","status"=>TRUE,"dependencies"=>["module"=>["node","user"]],
    "id"=>"eref_eval","label"=>"EREF Eval","module"=>"views","description"=>"","tag"=>"",
    "base_table"=>"node_field_data","base_field"=>"nid",
    "display"=>["default"=>["id"=>"default","display_title"=>"Default","display_plugin"=>"default","position"=>0,
      "display_options"=>["filters"=>[
        "eref_node_titles"=>["id"=>"eref_node_titles","table"=>"node_field_data","field"=>"eref_node_titles","plugin_id"=>"eref_node_titles","relationship"=>"none","exposed"=>TRUE],
      ]]]],
  ];
  \Drupal::configFactory()->getEditable("views.view.eref_eval")->setData($data)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: views.view.eref_eval created with eref_node_titles filter"
