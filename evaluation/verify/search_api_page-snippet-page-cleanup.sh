#!/usr/bin/env bash
# MEDIUM introspection cleanup: remove the staged knowledge_base_search page and the
# throwaway server + index created by search_api_page-snippet-page-setup.sh.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (["search_api_page"=>"knowledge_base_search","search_api_index"=>"sap_snippet_index","search_api_server"=>"sap_snippet_server"] as $type=>$id) {
    if ($e = \Drupal::entityTypeManager()->getStorage($type)->load($id)) { $e->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: knowledge_base_search + sap_snippet_index + sap_snippet_server removed"
