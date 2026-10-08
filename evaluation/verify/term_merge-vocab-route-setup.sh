#!/usr/bin/env bash
# Introspection SETUP: create a vocabulary whose LABEL ("TM Dupes") deliberately does not
# match its machine name (tm_dupes_x9), holding two obvious duplicate terms plus one distinct
# term. The agent must inspect the live site to discover the real vid before it can name
# term_merge's Merge form path for that vocabulary. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Term;
  use Drupal\taxonomy\Entity\Vocabulary;
  if (!Vocabulary::load("tm_dupes_x9")) {
    Vocabulary::create(["vid" => "tm_dupes_x9", "name" => "TM Dupes"])->save();
  }
  $ts = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  foreach ($ts->loadByProperties(["vid" => "tm_dupes_x9"]) as $t) { $t->delete(); }
  foreach (["Kayak", "Kayaks", "Canoe"] as $name) {
    Term::create(["vid" => "tm_dupes_x9", "name" => $name])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: vocabulary label 'TM Dupes' vid=tm_dupes_x9 with terms Kayak, Kayaks, Canoe"
