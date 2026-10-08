#!/usr/bin/env bash
# Introspection SETUP: seed search_api_stats rows for server 'sasblk_srv' / index 'sasblk_idx'
# so the top-terms block query has an unambiguous winner: 'blkterm_win' x4 vs 'blkterm_lose' x1.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $db = \Drupal::database();
  $db->delete("search_api_stats")->condition("i_name","sasblk_idx")->execute();
  $t = \Drupal::time()->getRequestTime();
  $rows = [["blkterm_win",3],["blkterm_win",3],["blkterm_win",3],["blkterm_win",3],["blkterm_lose",9]];
  foreach ($rows as $r) {
    $db->insert("search_api_stats")->fields([
      "s_name"=>"sasblk_srv","i_name"=>"sasblk_idx","timestamp"=>$t,"numfound"=>$r[1],
      "uid"=>0,"sid"=>"sascli","keywords"=>$r[0],"filters"=>"","sort"=>"","language"=>"en",
    ])->execute();
  }
' >/dev/null 2>&1
echo "setup: index sasblk_idx (server sasblk_srv) blkterm_win x4, blkterm_lose x1"
