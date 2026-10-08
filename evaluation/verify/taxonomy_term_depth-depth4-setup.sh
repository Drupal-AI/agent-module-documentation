#!/usr/bin/env bash
# Introspection SETUP: build vocab ttd_eval_m2 with a 4-level chain
# TTD L1(1) -> TTD L2(2) -> TTD L3(3) -> TTD L4(4), so an agent can read the deepest stored depth.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\taxonomy\Entity\Term;
  if ($v=Vocabulary::load("ttd_eval_m2")) { foreach(\Drupal::entityTypeManager()->getStorage("taxonomy_term")->loadByProperties(["vid"=>"ttd_eval_m2"]) as $t){$t->delete();} }
  else { Vocabulary::create(["vid"=>"ttd_eval_m2","name"=>"TTD Eval M2"])->save(); }
  $p=NULL;
  foreach ([1,2,3,4] as $n) {
    $args=["vid"=>"ttd_eval_m2","name"=>"TTD L$n"];
    if ($p) { $args["parent"]=[$p]; }
    $t=Term::create($args);$t->save();$p=$t->id();
  }
' >/dev/null 2>&1
echo "setup: vocab ttd_eval_m2 with 4-level chain TTD L1..TTD L4"
