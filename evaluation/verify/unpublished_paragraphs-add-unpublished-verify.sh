#!/usr/bin/env bash
# Execution VERIFY: PASS when a node of type up_page titled 'UP Task Node' exists AND references
# at least one paragraph that is unpublished (status 0). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
$nst=\Drupal::entityTypeManager()->getStorage("node");
$ns=$nst->loadByProperties(["type"=>"up_page","title"=>"UP Task Node"]);
if(!$ns){print "FAIL nonode\n"; return;}
$found=FALSE;
foreach($ns as $n){
  foreach($n->get("field_up_paras")->referencedEntities() as $p){
    if(!$p->isPublished()){$found=TRUE;}
  }
}
print ($found ? "PASS" : "FAIL") . " node=yes unpublished_para=" . var_export($found, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
