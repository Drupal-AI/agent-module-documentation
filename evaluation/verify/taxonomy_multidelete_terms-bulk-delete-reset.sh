#!/usr/bin/env bash
# Execution RESET: (re)create vocabulary tmt_del with exactly 5 terms so verify FAILS until the
# agent deletes them all. Idempotent (rebuilds terms to 5). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\taxonomy\Entity\Term;
  if (!Vocabulary::load("tmt_del")) {
    Vocabulary::create(["vid" => "tmt_del", "name" => "TMT Delete Me"])->save();
  }
  $storage = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  $existing = $storage->loadByProperties(["vid" => "tmt_del"]);
  if ($existing) { $storage->delete($existing); }
  for ($i = 1; $i <= 5; $i++) {
    Term::create(["vid" => "tmt_del", "name" => "tmt_term_$i"])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: vocabulary tmt_del has 5 terms"
