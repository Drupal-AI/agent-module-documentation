#!/usr/bin/env bash
# Introspection SETUP: create the vocabulary pbt_user_vocab with the term "PBT User Term", two
# accounts (pbt_intro_reader, pbt_intro_other) and grant the term to pbt_intro_reader ONLY,
# writing a row in permissions_by_term_user. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Term;
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\user\Entity\User;
  if (!Vocabulary::load("pbt_user_vocab")) { Vocabulary::create(["vid" => "pbt_user_vocab", "name" => "PBT User Vocab"])->save(); }
  foreach (["pbt_intro_reader", "pbt_intro_other"] as $name) {
    if (!user_load_by_name($name)) {
      User::create([
        "name" => $name, "mail" => $name . "@example.com",
        "pass" => \Drupal::service("password_generator")->generate(), "status" => 1,
      ])->save();
    }
  }
  $storage = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  $found = $storage->loadByProperties(["vid" => "pbt_user_vocab", "name" => "PBT User Term"]);
  $term = $found ? reset($found) : NULL;
  if (!$term) { $term = Term::create(["vid" => "pbt_user_vocab", "name" => "PBT User Term", "langcode" => "en"]); $term->save(); }
  $reader = user_load_by_name("pbt_intro_reader");
  $db = \Drupal::database();
  $db->delete("permissions_by_term_user")->condition("tid", $term->id())->execute();
  \Drupal::service("permissions_by_term.access_storage")
    ->addTermPermissionsByUserIds([$reader->id()], (string) $term->id(), "en");
  print "tid=" . $term->id() . " reader_uid=" . $reader->id() . "\n";
  foreach ($db->select("permissions_by_term_user", "u")->fields("u")->condition("tid", $term->id())->execute()->fetchAll() as $row) {
    print "grant tid=" . $row->tid . " uid=" . $row->uid . " lang=" . $row->langcode . "\n";
  }
' 2>/dev/null
echo "setup: pbt_intro_reader granted the 'PBT User Term' term"
