#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Term;
  foreach (["Condo","Multi-Family","Residential"] as $name) {
    $ids = \Drupal::entityQuery("taxonomy_term")->accessCheck(FALSE)->condition("vid","real_estate")->condition("name",$name)->execute();
    foreach ($ids as $id) { if ($t = Term::load($id)) { $t->delete(); } }
  }
' >/dev/null 2>&1
echo "cleanup: real_estate property-type terms Condo, Multi-Family, Residential removed"
