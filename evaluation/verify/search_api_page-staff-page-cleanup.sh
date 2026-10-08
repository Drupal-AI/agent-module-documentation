#!/usr/bin/env bash
# MEDIUM introspection cleanup: remove the staged staff_directory_search page and the
# throwaway server + index created by search_api_page-staff-page-setup.sh.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (["search_api_page"=>"staff_directory_search","search_api_index"=>"sap_medium_index","search_api_server"=>"sap_medium_server"] as $type=>$id) {
    if ($e = \Drupal::entityTypeManager()->getStorage($type)->load($id)) { $e->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: staff_directory_search + sap_medium_index + sap_medium_server removed"
