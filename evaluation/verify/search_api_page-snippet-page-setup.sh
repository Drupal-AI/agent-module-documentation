#!/usr/bin/env bash
# MEDIUM introspection setup: stage a known search_api_page config entity with a distinctive
# results style + pager limit so the agent can read those values back from live config.
# Self-contained DB server + index to bind. Restored by search_api_page-snippet-page-cleanup.sh.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if (!\Drupal::entityTypeManager()->getStorage("search_api_server")->load("sap_snippet_server")) {
    \Drupal\search_api\Entity\Server::create(["id"=>"sap_snippet_server","name"=>"SAP Snippet Server","status"=>TRUE,"backend"=>"search_api_db","backend_config"=>["database"=>"default:default","min_chars"=>3]])->save();
  }
  if (!\Drupal::entityTypeManager()->getStorage("search_api_index")->load("sap_snippet_index")) {
    \Drupal\search_api\Entity\Index::create(["id"=>"sap_snippet_index","name"=>"SAP Snippet Index","status"=>TRUE,"server"=>"sap_snippet_server","datasource_settings"=>["entity:node"=>[]]])->save();
  }
  $p = \Drupal::entityTypeManager()->getStorage("search_api_page")->load("knowledge_base_search");
  if ($p) { $p->delete(); }
  \Drupal\search_api_page\Entity\SearchApiPage::create([
    "id" => "knowledge_base_search",
    "label" => "Knowledge base search",
    "path" => "kb/search",
    "index" => "sap_snippet_index",
    "clean_url" => TRUE,
    "limit" => 25,
    "style" => "search_results",
    "show_all_when_no_keys" => TRUE,
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: search_api_page 'knowledge_base_search' style=search_results limit=25 show_all_when_no_keys=TRUE"
