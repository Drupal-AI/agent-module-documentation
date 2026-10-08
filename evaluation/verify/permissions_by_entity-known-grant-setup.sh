#!/usr/bin/env bash
# Introspection SETUP: create the vocabulary pbe_grant_vocab with the term "PBE Grant Term",
# the role pbe_grant_role, grant that role the term, and limit permissions_by_term to that
# vocabulary so permissions_by_entity would actually act on entities referencing it.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Term;
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\user\Entity\Role;
  if (!Vocabulary::load("pbe_grant_vocab")) { Vocabulary::create(["vid" => "pbe_grant_vocab", "name" => "PBE Grant Vocab"])->save(); }
  if (!Role::load("pbe_grant_role")) { Role::create(["id" => "pbe_grant_role", "label" => "PBE Grant Role"])->save(); }
  $storage = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  $found = $storage->loadByProperties(["vid" => "pbe_grant_vocab", "name" => "PBE Grant Term"]);
  $term = $found ? reset($found) : NULL;
  if (!$term) { $term = Term::create(["vid" => "pbe_grant_vocab", "name" => "PBE Grant Term", "langcode" => "en"]); $term->save(); }
  $db = \Drupal::database();
  $db->delete("permissions_by_term_role")->condition("tid", $term->id())->execute();
  \Drupal::service("permissions_by_term.access_storage")
    ->addTermPermissionsByRoleIds(["pbe_grant_role"], $term->id(), "en");
  \Drupal::configFactory()->getEditable("permissions_by_term.settings")
    ->set("target_bundles", ["pbe_grant_vocab"])->save();
  print "tid=" . $term->id() . "\n";
  foreach ($db->select("permissions_by_term_role", "r")->fields("r")->condition("tid", $term->id())->execute()->fetchAll() as $row) {
    print "grant tid=" . $row->tid . " rid=" . $row->rid . "\n";
  }
' 2>/dev/null
echo "setup: pbe_grant_role granted 'PBE Grant Term', target_bundles=[pbe_grant_vocab]"
