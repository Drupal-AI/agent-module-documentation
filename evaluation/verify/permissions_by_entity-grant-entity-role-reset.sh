#!/usr/bin/env bash
# Execution RESET: create the vocabulary pbe_ent_vocab with the term "PBE Entity Term" and the
# role pbe_ent_role, remove every grant for that term and clear target_bundles — so the matching
# verify FAILS until the agent both grants the role and scopes the module to that vocabulary.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Term;
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\user\Entity\Role;
  if (!Vocabulary::load("pbe_ent_vocab")) { Vocabulary::create(["vid" => "pbe_ent_vocab", "name" => "PBE Entity Vocab"])->save(); }
  if (!Role::load("pbe_ent_role")) { Role::create(["id" => "pbe_ent_role", "label" => "PBE Entity Role"])->save(); }
  $storage = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  $found = $storage->loadByProperties(["vid" => "pbe_ent_vocab", "name" => "PBE Entity Term"]);
  $term = $found ? reset($found) : NULL;
  if (!$term) { $term = Term::create(["vid" => "pbe_ent_vocab", "name" => "PBE Entity Term", "langcode" => "en"]); $term->save(); }
  $db = \Drupal::database();
  $db->delete("permissions_by_term_role")->condition("tid", $term->id())->execute();
  $db->delete("permissions_by_term_user")->condition("tid", $term->id())->execute();
  \Drupal::configFactory()->getEditable("permissions_by_term.settings")->set("target_bundles", [])->save();
  print "tid=" . $term->id() . " grants=" . $db->select("permissions_by_term_role", "r")->condition("tid", $term->id())->countQuery()->execute()->fetchField() . "\n";
' 2>/dev/null
echo "reset: pbe_ent_vocab / 'PBE Entity Term' / pbe_ent_role present, no grants, target_bundles empty"
