#!/usr/bin/env bash
# Introspection SETUP: build vocab ttd_eval_m with a 3-level chain
# TTD Root(1) -> TTD Child(2) -> TTD Grand(3). The module auto-computes depth_level on save so an
# agent can read the stored depth. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\taxonomy\Entity\Term;
  if ($v=Vocabulary::load("ttd_eval_m")) { foreach(\Drupal::entityTypeManager()->getStorage("taxonomy_term")->loadByProperties(["vid"=>"ttd_eval_m"]) as $t){$t->delete();} }
  else { Vocabulary::create(["vid"=>"ttd_eval_m","name"=>"TTD Eval M"])->save(); }
  $r=Term::create(["vid"=>"ttd_eval_m","name"=>"TTD Root"]);$r->save();
  $c=Term::create(["vid"=>"ttd_eval_m","name"=>"TTD Child","parent"=>[$r->id()]]);$c->save();
  $g=Term::create(["vid"=>"ttd_eval_m","name"=>"TTD Grand","parent"=>[$c->id()]]);$g->save();
' >/dev/null 2>&1
echo "setup: vocab ttd_eval_m with TTD Root(1)/TTD Child(2)/TTD Grand(3)"
