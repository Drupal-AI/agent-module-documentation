#!/usr/bin/env bash
# Execution RESET: build vocab ttd_eval_h (TTD Root/TTD Child/TTD Grand) then NULL all depth_level
# values, so verify FAILS until the agent recalculates the depths. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\taxonomy\Entity\Term;
  if ($v=Vocabulary::load("ttd_eval_h")) { foreach(\Drupal::entityTypeManager()->getStorage("taxonomy_term")->loadByProperties(["vid"=>"ttd_eval_h"]) as $t){$t->delete();} }
  else { Vocabulary::create(["vid"=>"ttd_eval_h","name"=>"TTD Eval H"])->save(); }
  $r=Term::create(["vid"=>"ttd_eval_h","name"=>"TTD Root"]);$r->save();
  $c=Term::create(["vid"=>"ttd_eval_h","name"=>"TTD Child","parent"=>[$r->id()]]);$c->save();
  $g=Term::create(["vid"=>"ttd_eval_h","name"=>"TTD Grand","parent"=>[$c->id()]]);$g->save();
  \Drupal::database()->update("taxonomy_term_field_data")->fields(["depth_level"=>NULL])->condition("vid","ttd_eval_h")->execute();
' >/dev/null 2>&1
echo "reset: vocab ttd_eval_h built with depth_level cleared (NULL)"
