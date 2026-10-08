#!/usr/bin/env bash
# Execution VERIFY: PASS when node sna_del_node exists but has NO /sna-old-alias alias anymore.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ids=\Drupal::entityTypeManager()->getStorage("node")->getQuery()->accessCheck(FALSE)->condition("title","sna_del_node")->execute();
  $nid=$ids?reset($ids):NULL; $ok=FALSE;
  if ($nid){
    $m=\Drupal::entityTypeManager()->getStorage("path_alias")->loadByProperties(["path"=>"/node/".$nid,"alias"=>"/sna-old-alias"]);
    $ok = empty($m);
  }
  print ($ok?"PASS":"FAIL")." nid=".var_export($nid,TRUE)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
