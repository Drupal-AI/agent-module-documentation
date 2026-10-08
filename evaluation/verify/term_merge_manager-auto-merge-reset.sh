#!/usr/bin/env bash
# Execution RESET: ensure vocabulary tmm_task exists with a target term "Cats", and remove ALL
# merge rules and stray probe terms for tmm_task so that (until the agent adds a rule) a newly
# created term named "kitten" would NOT be merged. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\taxonomy\Entity\Term;
  use Drupal\term_merge_manager\Entity\TermMergeInto;
  use Drupal\term_merge_manager\Entity\TermMergeFrom;
  if (!Vocabulary::load("tmm_task")) { Vocabulary::create(["vid"=>"tmm_task","name"=>"TMM Task"])->save(); }
  foreach (\Drupal::entityQuery("term_merge_from")->condition("vid","tmm_task")->accessCheck(FALSE)->execute() as $id) { TermMergeFrom::load($id)?->delete(); }
  foreach (\Drupal::entityQuery("term_merge_into")->condition("vid","tmm_task")->accessCheck(FALSE)->execute() as $id) { TermMergeInto::load($id)?->delete(); }
  // Remove any stray "kitten" probe terms, keep exactly one "Cats" target.
  foreach (\Drupal::entityQuery("taxonomy_term")->condition("vid","tmm_task")->condition("name","kitten")->accessCheck(FALSE)->execute() as $tid) { Term::load($tid)?->delete(); }
  $cats = \Drupal::entityQuery("taxonomy_term")->condition("vid","tmm_task")->condition("name","Cats")->accessCheck(FALSE)->execute();
  if (!$cats) { Term::create(["vid"=>"tmm_task","name"=>"Cats"])->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: tmm_task has target 'Cats', no merge rules"
