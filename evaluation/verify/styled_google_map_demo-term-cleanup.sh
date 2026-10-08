#!/usr/bin/env bash
# Introspection CLEANUP: delete the known real_estate term. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Term;
  $ids = \Drupal::entityQuery("taxonomy_term")->accessCheck(FALSE)->condition("vid","real_estate")->condition("name","SGM Demo Type Alpha")->execute();
  foreach ($ids as $id) { if ($t = Term::load($id)) { $t->delete(); } }
' >/dev/null 2>&1
echo "cleanup: taxonomy term 'SGM Demo Type Alpha' removed"
