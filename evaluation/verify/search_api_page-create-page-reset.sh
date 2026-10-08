#!/usr/bin/env bash
# HARD execution reset: start each attempt from a known state.
#  - Ensure a bindable Search API index exists (create a DB-backed server + index if missing),
#    so the agent has a real index to bind the new search page to.
#  - Remove the target search_api_page config entity ('site_search') so the build task starts
#    from a missing (failing) state.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if (!\Drupal::entityTypeManager()->getStorage("search_api_server")->load("sap_eval_server")) {
    \Drupal\search_api\Entity\Server::create(["id"=>"sap_eval_server","name"=>"SAP Eval Server","status"=>TRUE,"backend"=>"search_api_db","backend_config"=>["database"=>"default:default","min_chars"=>3]])->save();
  }
  if (!\Drupal::entityTypeManager()->getStorage("search_api_index")->load("sap_eval_index")) {
    \Drupal\search_api\Entity\Index::create(["id"=>"sap_eval_index","name"=>"SAP Eval Index","status"=>TRUE,"server"=>"sap_eval_server","datasource_settings"=>["entity:node"=>[]]])->save();
  }
  if ($p = \Drupal::entityTypeManager()->getStorage("search_api_page")->load("site_search")) { $p->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: bindable index sap_eval_index ensured; search_api_page 'site_search' removed (if it existed)"
