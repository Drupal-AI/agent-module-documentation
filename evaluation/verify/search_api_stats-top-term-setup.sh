#!/usr/bin/env bash
# Introspection SETUP: insert several namespaced log rows (index i_name='sas_topidx') so the
# most-searched keyword is unambiguous: 'sasterm_alpha' x3, 'sasterm_beta' x1. The agent must
# aggregate the live search_api_stats table (as a top-terms report would). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $db = \Drupal::database();
  $db->delete("search_api_stats")->condition("i_name","sas_topidx")->execute();
  $t = \Drupal::time()->getRequestTime();
  $rows = [
    ["sasterm_alpha",5],["sasterm_alpha",5],["sasterm_alpha",5],["sasterm_beta",2],
  ];
  foreach ($rows as $r) {
    $db->insert("search_api_stats")->fields([
      "s_name"=>"sas_srv","i_name"=>"sas_topidx","timestamp"=>$t,
      "numfound"=>$r[1],"uid"=>0,"sid"=>"sascli","keywords"=>$r[0],
      "filters"=>"","sort"=>"","language"=>"en",
    ])->execute();
  }
' >/dev/null 2>&1
echo "setup: i_name=sas_topidx sasterm_alpha x3, sasterm_beta x1"
