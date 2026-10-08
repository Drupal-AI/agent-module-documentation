#!/usr/bin/env bash
# Introspection SETUP: create disabled Search API index sahef_index and configure the
# html_element_filter processor with css_selectors='.sidebar-filters' so an agent can read it
# back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\search_api\Entity\Index;
  if (!Index::load("sahef_index")) {
    Index::create(["id" => "sahef_index", "name" => "SAHEF Index", "status" => FALSE,
      "datasource_settings" => ["entity:node" => []], "tracker_settings" => ["default" => []]])->save();
  }
  $c = \Drupal::configFactory()->getEditable("search_api.index.sahef_index");
  $ps = $c->get("processor_settings") ?? [];
  $ps["html_element_filter"] = ["css_selectors" => ".sidebar-filters", "enable_postprocess_query" => TRUE,
    "all_fields" => TRUE, "fields" => [], "weights" => ["preprocess_index" => -30, "postprocess_query" => -30]];
  $c->set("processor_settings", $ps)->save();
' >/dev/null 2>&1
echo "setup: search_api.index.sahef_index html_element_filter css_selectors=.sidebar-filters"
