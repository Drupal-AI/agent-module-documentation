#!/usr/bin/env bash
# VERIFY: PASS when ruc_source owns 0 nodes and both fixture nodes are owned by ruc_dest.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $g = \Drupal::entityTypeManager()->getStorage("user");
  $src = $g->loadByProperties(["name"=>"ruc_source"]); $dest = $g->loadByProperties(["name"=>"ruc_dest"]);
  if (!$src || !$dest) { print "FAIL missing-user"; return; }
  $src = reset($src); $dest = reset($dest);
  $ns = \Drupal::entityTypeManager()->getStorage("node");
  $src_count = (int) $ns->getQuery()->accessCheck(FALSE)->condition("uid",$src->id())->count()->execute();
  $ok_dest = TRUE;
  foreach (["RUC All Node 1","RUC All Node 2"] as $t) {
    $nodes = $ns->loadByProperties(["title"=>$t]);
    $n = $nodes ? reset($nodes) : NULL;
    if (!$n || (int) $n->getOwnerId() !== (int) $dest->id()) { $ok_dest = FALSE; }
  }
  print (($src_count === 0 && $ok_dest) ? "PASS" : "FAIL") . " src_nodes=$src_count";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
