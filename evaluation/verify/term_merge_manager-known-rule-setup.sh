#!/usr/bin/env bash
# Introspection SETUP: create vocabulary tmm_intro with a target term "Automobiles" and a
# term-merge rule so that the source name "Cars" folds into it. An inspecting agent should be
# able to read back that "Cars" merges into "Automobiles". Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\taxonomy\Entity\Term;
  use Drupal\term_merge_manager\Entity\TermMergeInto;
  use Drupal\term_merge_manager\Entity\TermMergeFrom;
  if (!Vocabulary::load("tmm_intro")) { Vocabulary::create(["vid"=>"tmm_intro","name"=>"TMM Intro"])->save(); }
  $ids = \Drupal::entityQuery("taxonomy_term")->condition("vid","tmm_intro")->condition("name","Automobiles")->accessCheck(FALSE)->execute();
  if ($ids) { $target = Term::load(reset($ids)); } else { $target = Term::create(["vid"=>"tmm_intro","name"=>"Automobiles"]); $target->save(); }
  $intoId = TermMergeInto::loadIdByTid($target->id());
  if ($intoId === FALSE) { $into = TermMergeInto::create(["tid"=>$target->id(),"vid"=>"tmm_intro"]); $into->save(); $intoId = $into->id(); }
  if (TermMergeFrom::loadByVidName("tmm_intro","Cars") === FALSE) {
    $from = TermMergeFrom::create(); $from->set("tmiid",$intoId); $from->set("vid","tmm_intro"); $from->set("name","Cars"); $from->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: tmm_intro rule 'Cars' -> 'Automobiles' created"
