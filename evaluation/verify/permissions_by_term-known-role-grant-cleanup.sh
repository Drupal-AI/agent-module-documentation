#!/usr/bin/env bash
# Introspection CLEANUP: delete the pbt_intro_vocab vocabulary (and its terms), the
# pbt_intro_role role, and any leftover grant rows. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\user\Entity\Role;
  $storage = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  $db = \Drupal::database();
  foreach ($storage->loadByProperties(["vid" => "pbt_intro_vocab"]) as $term) {
    $db->delete("permissions_by_term_role")->condition("tid", $term->id())->execute();
    $db->delete("permissions_by_term_user")->condition("tid", $term->id())->execute();
    $term->delete();
  }
  if ($v = Vocabulary::load("pbt_intro_vocab")) { $v->delete(); }
  if ($r = Role::load("pbt_intro_role")) { $r->delete(); }
  print "cleaned\n";
' 2>/dev/null
echo "cleanup: pbt_intro_vocab / pbt_intro_role removed"
