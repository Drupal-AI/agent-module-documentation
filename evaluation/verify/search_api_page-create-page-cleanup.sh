#!/usr/bin/env bash
# HARD execution cleanup (optional): remove the built search page and the throwaway
# server + index created by search_api_page-create-page-reset.sh, leaving the site clean.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (["search_api_page"=>"site_search","search_api_index"=>"sap_eval_index","search_api_server"=>"sap_eval_server"] as $type=>$id) {
    if ($e = \Drupal::entityTypeManager()->getStorage($type)->load($id)) { $e->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: site_search + sap_eval_index + sap_eval_server removed"
