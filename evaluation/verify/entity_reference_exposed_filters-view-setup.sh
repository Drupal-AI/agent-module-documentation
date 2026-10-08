#!/usr/bin/env bash
# Introspection SETUP: create a View eref_eval whose default display uses the eref_node_titles
# filter, so an agent can inspect the view and identify the filter plugin. Idempotent.
# NOTE: the filtered view is written as raw config (config factory) rather than via
# View::create()->save(). This establishes the identical known state without triggering the
# Views filter-plugin *discovery* pass that entity-save runs — on shared sites where an
# unrelated contrib module ships a views filter with an incompatible method signature, that
# discovery pass fatals. A fixture must be robust to co-installed modules; the agent still
# inspects the same views.view.eref_eval config.
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
echo "setup: views.view.eref_eval created with eref_node_titles filter"
