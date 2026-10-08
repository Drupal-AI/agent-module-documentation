#!/usr/bin/env bash
# Introspection SETUP: create the vocabulary pbt_intro_vocab with two terms ("PBT Intro Secret"
# and "PBT Intro Public"), the role pbt_intro_role, and grant that role access to the SECRET
# term only (via permissions_by_term.access_storage, which writes permissions_by_term_role).
# The agent must read the live grant tables to say who may access the term. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Term;
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\user\Entity\Role;
  if (!Vocabulary::load("pbt_intro_vocab")) { Vocabulary::create(["vid" => "pbt_intro_vocab", "name" => "PBT Intro Vocab"])->save(); }
  if (!Role::load("pbt_intro_role")) { Role::create(["id" => "pbt_intro_role", "label" => "PBT Intro Role"])->save(); }
  $storage = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  $tids = [];
  foreach (["PBT Intro Secret", "PBT Intro Public"] as $name) {
    $found = $storage->loadByProperties(["vid" => "pbt_intro_vocab", "name" => $name]);
    $term = $found ? reset($found) : NULL;
    if (!$term) { $term = Term::create(["vid" => "pbt_intro_vocab", "name" => $name, "langcode" => "en"]); $term->save(); }
    $tids[$name] = $term->id();
  }
  $db = \Drupal::database();
  foreach ($tids as $tid) { $db->delete("permissions_by_term_role")->condition("tid", $tid)->execute(); }
  \Drupal::service("permissions_by_term.access_storage")
    ->addTermPermissionsByRoleIds(["pbt_intro_role"], $tids["PBT Intro Secret"], "en");
  print "secret_tid=" . $tids["PBT Intro Secret"] . " public_tid=" . $tids["PBT Intro Public"] . "\n";
  foreach ($db->select("permissions_by_term_role", "r")->fields("r")->execute()->fetchAll() as $row) {
    print "grant tid=" . $row->tid . " rid=" . $row->rid . " lang=" . $row->langcode . "\n";
  }
' 2>/dev/null
echo "setup: pbt_intro_role granted the 'PBT Intro Secret' term"
