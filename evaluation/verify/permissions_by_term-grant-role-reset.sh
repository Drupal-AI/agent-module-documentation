#!/usr/bin/env bash
# Execution RESET: ensure the vocabulary pbt_task_vocab, the term "PBT Task Term" and the role
# pbt_task_role exist, and that NO permissions_by_term grant rows exist for that term — so the
# matching verify FAILS until the agent grants the role access to the term. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Term;
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\user\Entity\Role;
  if (!Vocabulary::load("pbt_task_vocab")) { Vocabulary::create(["vid" => "pbt_task_vocab", "name" => "PBT Task Vocab"])->save(); }
  if (!Role::load("pbt_task_role")) { Role::create(["id" => "pbt_task_role", "label" => "PBT Task Role"])->save(); }
  $storage = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  $found = $storage->loadByProperties(["vid" => "pbt_task_vocab", "name" => "PBT Task Term"]);
  $term = $found ? reset($found) : NULL;
  if (!$term) { $term = Term::create(["vid" => "pbt_task_vocab", "name" => "PBT Task Term", "langcode" => "en"]); $term->save(); }
  $db = \Drupal::database();
  $db->delete("permissions_by_term_role")->condition("tid", $term->id())->execute();
  $db->delete("permissions_by_term_user")->condition("tid", $term->id())->execute();
  print "tid=" . $term->id() . " role_grants=" . $db->select("permissions_by_term_role", "r")->condition("tid", $term->id())->countQuery()->execute()->fetchField() . "\n";
' 2>/dev/null
echo "reset: pbt_task_vocab / 'PBT Task Term' / pbt_task_role present, no grants"
