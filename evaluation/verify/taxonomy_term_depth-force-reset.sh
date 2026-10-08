#!/usr/bin/env bash
# Execution RESET: build vocab ttd_eval_h2 (TTD Parent -> TTD Kid, so Kid's true depth is 2) then
# corrupt TTD Kid's stored depth_level to 99, so verify FAILS until the agent force-recalculates
# that term. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\taxonomy\Entity\Term;
  if ($v=Vocabulary::load("ttd_eval_h2")) { foreach(\Drupal::entityTypeManager()->getStorage("taxonomy_term")->loadByProperties(["vid"=>"ttd_eval_h2"]) as $t){$t->delete();} }
  else { Vocabulary::create(["vid"=>"ttd_eval_h2","name"=>"TTD Eval H2"])->save(); }
  $p=Term::create(["vid"=>"ttd_eval_h2","name"=>"TTD Parent"]);$p->save();
  $k=Term::create(["vid"=>"ttd_eval_h2","name"=>"TTD Kid","parent"=>[$p->id()]]);$k->save();
  \Drupal::database()->update("taxonomy_term_field_data")->fields(["depth_level"=>99])->condition("tid",$k->id())->execute();
' >/dev/null 2>&1
echo "reset: vocab ttd_eval_h2, TTD Kid depth_level corrupted to 99 (true depth is 2)"
