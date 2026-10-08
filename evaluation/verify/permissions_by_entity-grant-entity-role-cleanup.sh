#!/usr/bin/env bash
# Execution CLEANUP: delete the pbe_ent_vocab vocabulary with its terms and grants, the
# pbe_ent_role role, and restore target_bundles to the shipped default. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\user\Entity\Role;
  $storage = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  $db = \Drupal::database();
  foreach ($storage->loadByProperties(["vid" => "pbe_ent_vocab"]) as $term) {
    $db->delete("permissions_by_term_role")->condition("tid", $term->id())->execute();
    $db->delete("permissions_by_term_user")->condition("tid", $term->id())->execute();
    $term->delete();
  }
  if ($v = Vocabulary::load("pbe_ent_vocab")) { $v->delete(); }
  if ($r = Role::load("pbe_ent_role")) { $r->delete(); }
  \Drupal::configFactory()->getEditable("permissions_by_term.settings")->set("target_bundles", [])->save();
  print "cleaned\n";
' 2>/dev/null
echo "cleanup: pbe_ent_vocab / pbe_ent_role removed, target_bundles reset"
