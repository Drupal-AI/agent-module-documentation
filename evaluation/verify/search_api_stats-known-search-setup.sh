#!/usr/bin/env bash
# Introspection SETUP: insert one known Search API Stats log row so an inspecting agent can
# read back its result count. Row is namespaced (s_name='sas_srv', keyword 'sasneedle_zorp').
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $db = \Drupal::database();
  $db->delete("search_api_stats")->condition("keywords","sasneedle_zorp")->execute();
  $db->insert("search_api_stats")->fields([
    "s_name"=>"sas_srv","i_name"=>"sas_idx","timestamp"=>\Drupal::time()->getRequestTime(),
    "numfound"=>77,"uid"=>0,"sid"=>"sascli","keywords"=>"sasneedle_zorp",
    "filters"=>"","sort"=>"","language"=>"en",
  ])->execute();
' >/dev/null 2>&1
echo "setup: search_api_stats row keywords=sasneedle_zorp numfound=77"
