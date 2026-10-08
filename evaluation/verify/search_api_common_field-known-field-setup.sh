#!/usr/bin/env bash
# Introspection SETUP: build a disabled Search API index scf_known with two datasources
# (node, user) and a Common field (processor common_field) whose source property_name is
# 'langcode', so an inspecting agent can read the merged source back. No server needed.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\search_api\Entity\Index;
  if ($i = Index::load("scf_known")) { $i->delete(); }
  $index = Index::create([
    "id" => "scf_known", "name" => "SCF Known", "status" => FALSE,
    "datasource_settings" => ["entity:node" => [], "entity:user" => []],
  ]);
  $index->save();
  $index->addProcessor(\Drupal::getContainer()->get("search_api.plugin_helper")->createProcessorPlugin($index, "common_field"));
  $fh = \Drupal::getContainer()->get("search_api.fields_helper");
  $field = $fh->createField($index, "scf_common", [
    "label" => "Common langcode", "type" => "string",
    "datasource_id" => NULL, "property_path" => "common_field",
    "configuration" => ["property_name" => "langcode"],
  ]);
  $index->addField($field);
  $index->save();
' >/dev/null 2>&1
echo "setup: index scf_known has Common field scf_common (property_name=langcode)"
