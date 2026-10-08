#!/usr/bin/env bash
# Execution RESET: ensure Search API index sahef_task exists and has NO html_element_filter
# processor (so verify FAILS until the agent adds it). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\search_api\Entity\Index;
  if (!Index::load("sahef_task")) {
    Index::create(["id" => "sahef_task", "name" => "SAHEF Task", "status" => FALSE,
      "datasource_settings" => ["entity:node" => []], "tracker_settings" => ["default" => []]])->save();
  }
  $c = \Drupal::configFactory()->getEditable("search_api.index.sahef_task");
  $ps = $c->get("processor_settings") ?? [];
  unset($ps["html_element_filter"]);
  $c->set("processor_settings", $ps)->save();
' >/dev/null 2>&1
echo "reset: sahef_task present without html_element_filter processor"
