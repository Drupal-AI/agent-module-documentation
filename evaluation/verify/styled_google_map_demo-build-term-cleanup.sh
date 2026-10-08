#!/usr/bin/env bash
# Execution CLEANUP: delete the real_estate term named 'SGM Task Type'. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Term;
  $ids = \Drupal::entityQuery("taxonomy_term")->accessCheck(FALSE)->condition("vid","real_estate")->condition("name","SGM Task Type")->execute();
  foreach ($ids as $id) { if ($t = Term::load($id)) { $t->delete(); } }
' >/dev/null 2>&1
echo "cleanup: real_estate term 'SGM Task Type' removed"
