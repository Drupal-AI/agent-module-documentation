#!/usr/bin/env bash
# Introspection CLEANUP: delete the pbt_user_vocab vocabulary and its terms, the two fixture
# accounts and their grant rows. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  $storage = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  $db = \Drupal::database();
  foreach ($storage->loadByProperties(["vid" => "pbt_user_vocab"]) as $term) {
    $db->delete("permissions_by_term_user")->condition("tid", $term->id())->execute();
    $db->delete("permissions_by_term_role")->condition("tid", $term->id())->execute();
    $term->delete();
  }
  if ($v = Vocabulary::load("pbt_user_vocab")) { $v->delete(); }
  foreach (["pbt_intro_reader", "pbt_intro_other"] as $name) {
    if ($u = user_load_by_name($name)) { $u->delete(); }
  }
  print "cleaned\n";
' 2>/dev/null
echo "cleanup: pbt_user_vocab and fixture accounts removed"
