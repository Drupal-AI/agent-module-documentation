#!/usr/bin/env bash
# Execution RESET: create vocabulary flattax_tree with a nested pair (Child B under Parent A),
# NOT flat. Verify FAILS while a term still has a parent. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\taxonomy\Entity\Term;
  if ($v = Vocabulary::load("flattax_tree")) {
    foreach (\Drupal::entityTypeManager()->getStorage("taxonomy_term")->loadByProperties(["vid"=>"flattax_tree"]) as $t) { $t->delete(); }
    $v->unsetThirdPartySetting("flat_taxonomy","flat"); $v->save();
  } else {
    Vocabulary::create(["vid"=>"flattax_tree","name"=>"Flat Tree"])->save();
  }
  $a = Term::create(["vid"=>"flattax_tree","name"=>"FT Parent A"]); $a->save();
  $b = Term::create(["vid"=>"flattax_tree","name"=>"FT Child B","parent"=>[$a->id()]]); $b->save();
' >/dev/null 2>&1
echo "reset: vocabulary flattax_tree has nested terms (Child B under Parent A), not flat"
