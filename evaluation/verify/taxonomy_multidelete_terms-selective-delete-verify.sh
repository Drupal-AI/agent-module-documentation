#!/usr/bin/env bash
# PASS when the 3 tmt_del_* terms are gone AND the 3 tmt_keep_* terms remain.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s=\Drupal::entityTypeManager()->getStorage("taxonomy_term");
  $all=$s->loadByProperties(["vid"=>"tmt_half"]);
  $keep=0;$del=0;
  foreach($all as $t){ if(strpos($t->label(),"tmt_keep_")===0){$keep++;} if(strpos($t->label(),"tmt_del_")===0){$del++;} }
  $ok=($del===0 && $keep===3);
  print ($ok?"PASS":"FAIL")." keep=$keep del=$del\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
