#!/usr/bin/env bash
# Execution RESET: seed marker rows (s_name='sasclear') into search_api_stats so verify FAILS
# until the agent clears them. Idempotent (re-seeds). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $db = \Drupal::database();
  $db->delete("search_api_stats")->condition("s_name","sasclear")->execute();
  $t = \Drupal::time()->getRequestTime();
  foreach (["sasclr_one","sasclr_two","sasclr_three"] as $k) {
    $db->insert("search_api_stats")->fields([
      "s_name"=>"sasclear","i_name"=>"sasclr_idx","timestamp"=>$t,"numfound"=>1,
      "uid"=>0,"sid"=>"sascli","keywords"=>$k,"filters"=>"","sort"=>"","language"=>"en",
    ])->execute();
  }
' >/dev/null 2>&1
echo "reset: 3 marker rows (s_name=sasclear) present"
