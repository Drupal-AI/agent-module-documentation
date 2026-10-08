#!/usr/bin/env bash
# Execution CLEANUP: remove any remaining tmm_del rules, terms and the vocabulary. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\taxonomy\Entity\Term;
  use Drupal\term_merge_manager\Entity\TermMergeInto;
  use Drupal\term_merge_manager\Entity\TermMergeFrom;
  foreach (\Drupal::entityQuery("term_merge_from")->condition("vid","tmm_del")->accessCheck(FALSE)->execute() as $id) { TermMergeFrom::load($id)?->delete(); }
  foreach (\Drupal::entityQuery("term_merge_into")->condition("vid","tmm_del")->accessCheck(FALSE)->execute() as $id) { TermMergeInto::load($id)?->delete(); }
  foreach (\Drupal::entityQuery("taxonomy_term")->condition("vid","tmm_del")->accessCheck(FALSE)->execute() as $tid) { Term::load($tid)?->delete(); }
  if ($v = Vocabulary::load("tmm_del")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: tmm_del removed"
