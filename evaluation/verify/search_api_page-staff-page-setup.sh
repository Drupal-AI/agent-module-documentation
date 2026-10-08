#!/usr/bin/env bash
# MEDIUM introspection setup: stage a known search_api_page config entity so the agent can
# be asked to read back its path and bound index from live config.
# Creates a self-contained DB server + index to bind (no external search service needed).
# Restored by search_api_page-staff-page-cleanup.sh.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if (!\Drupal::entityTypeManager()->getStorage("search_api_server")->load("sap_medium_server")) {
    \Drupal\search_api\Entity\Server::create(["id"=>"sap_medium_server","name"=>"SAP Medium Server","status"=>TRUE,"backend"=>"search_api_db","backend_config"=>["database"=>"default:default","min_chars"=>3]])->save();
  }
  if (!\Drupal::entityTypeManager()->getStorage("search_api_index")->load("sap_medium_index")) {
    \Drupal\search_api\Entity\Index::create(["id"=>"sap_medium_index","name"=>"SAP Medium Index","status"=>TRUE,"server"=>"sap_medium_server","datasource_settings"=>["entity:node"=>[]]])->save();
  }
  $p = \Drupal::entityTypeManager()->getStorage("search_api_page")->load("staff_directory_search");
  if ($p) { $p->delete(); }
  \Drupal\search_api_page\Entity\SearchApiPage::create([
    "id" => "staff_directory_search",
    "label" => "Staff directory search",
    "path" => "search/staff",
    "index" => "sap_medium_index",
    "clean_url" => TRUE,
    "limit" => 10,
    "style" => "view_modes",
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: search_api_page 'staff_directory_search' at path search/staff bound to index sap_medium_index"
