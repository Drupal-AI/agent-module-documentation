#!/usr/bin/env bash
# Introspection SETUP: create disabled index sahef_pp with html_element_filter processor whose
# enable_postprocess_query is FALSE, so an agent can read that setting back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\search_api\Entity\Index;
  if (!Index::load("sahef_pp")) {
    Index::create(["id" => "sahef_pp", "name" => "SAHEF PP", "status" => FALSE,
      "datasource_settings" => ["entity:node" => []], "tracker_settings" => ["default" => []]])->save();
  }
  $c = \Drupal::configFactory()->getEditable("search_api.index.sahef_pp");
  $ps = $c->get("processor_settings") ?? [];
  $ps["html_element_filter"] = ["css_selectors" => ".advert", "enable_postprocess_query" => FALSE,
    "all_fields" => TRUE, "fields" => [], "weights" => ["preprocess_index" => -30]];
  $c->set("processor_settings", $ps)->save();
' >/dev/null 2>&1
echo "setup: sahef_pp html_element_filter enable_postprocess_query=FALSE"
