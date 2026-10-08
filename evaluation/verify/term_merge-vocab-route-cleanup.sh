#!/usr/bin/env bash
# Introspection CLEANUP: delete the tm_dupes_x9 vocabulary and its terms created by the
# matching setup. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  foreach (\Drupal::entityTypeManager()->getStorage("taxonomy_term")
    ->loadByProperties(["vid" => "tm_dupes_x9"]) as $t) { $t->delete(); }
  if ($v = Vocabulary::load("tm_dupes_x9")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: vocabulary tm_dupes_x9 and its terms removed"
