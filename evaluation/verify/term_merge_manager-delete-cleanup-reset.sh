#!/usr/bin/env bash
# Execution RESET: create vocabulary tmm_del with a target term "Obsolete" and a full merge rule
# (term_merge_into for the target + a term_merge_from "OldName" pointing at it). Leaves the rules
# PRESENT, so verify FAILS until the agent deletes the target term (whose delete hook must remove
# the rules). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\taxonomy\Entity\Term;
  use Drupal\term_merge_manager\Entity\TermMergeInto;
  use Drupal\term_merge_manager\Entity\TermMergeFrom;
  if (!Vocabulary::load("tmm_del")) { Vocabulary::create(["vid"=>"tmm_del","name"=>"TMM Del"])->save(); }
  // Clear any leftover rules/terms first.
  foreach (\Drupal::entityQuery("term_merge_from")->condition("vid","tmm_del")->accessCheck(FALSE)->execute() as $id) { TermMergeFrom::load($id)?->delete(); }
  foreach (\Drupal::entityQuery("term_merge_into")->condition("vid","tmm_del")->accessCheck(FALSE)->execute() as $id) { TermMergeInto::load($id)?->delete(); }
  foreach (\Drupal::entityQuery("taxonomy_term")->condition("vid","tmm_del")->accessCheck(FALSE)->execute() as $tid) { Term::load($tid)?->delete(); }
  $target = Term::create(["vid"=>"tmm_del","name"=>"Obsolete"]); $target->save();
  $into = TermMergeInto::create(["tid"=>$target->id(),"vid"=>"tmm_del"]); $into->save();
  $from = TermMergeFrom::create(); $from->set("tmiid",$into->id()); $from->set("vid","tmm_del"); $from->set("name","OldName"); $from->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: tmm_del target 'Obsolete' with merge rules present"
