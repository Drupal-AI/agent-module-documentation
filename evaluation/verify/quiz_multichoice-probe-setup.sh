#!/usr/bin/env bash
# Introspection SETUP: create a multichoice quiz question titled quiz_mc_probe with exactly 3
# alternatives (Paris correct, Rome & Berlin incorrect), so the agent must inspect the live
# question to report how many alternatives it has. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\quiz\Entity\QuizQuestion;
  use Drupal\paragraphs\Entity\Paragraph;
  if (!\Drupal::entityTypeManager()->getStorage("quiz_question")->loadByProperties(["type"=>"multichoice","title"=>"quiz_mc_probe"])) {
    $alts = [];
    foreach ([["Paris",1],["Rome",0],["Berlin",0]] as $a) {
      $p = Paragraph::create(["type"=>"multichoice","multichoice_answer"=>$a[0],"multichoice_correct"=>$a[1],"multichoice_score_chosen"=>$a[1]]);
      $p->save();
      $alts[] = $p;
    }
    QuizQuestion::create(["type"=>"multichoice","title"=>"quiz_mc_probe","choice_multi"=>0,"choice_random"=>0,"choice_boolean"=>1,"alternatives"=>$alts])->save();
  }
' >/dev/null 2>&1
echo "setup: multichoice question quiz_mc_probe has 3 alternatives (Paris correct)"
