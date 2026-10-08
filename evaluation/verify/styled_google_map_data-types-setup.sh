#!/usr/bin/env bash
# Introspection SETUP: create the property-type terms the data submodule installs. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Term;
  foreach (["Condo","Multi-Family","Residential"] as $name) {
    $ids = \Drupal::entityQuery("taxonomy_term")->accessCheck(FALSE)->condition("vid","real_estate")->condition("name",$name)->execute();
    if (!$ids) { Term::create(["vid"=>"real_estate","name"=>$name])->save(); }
  }
' >/dev/null 2>&1
echo "setup: real_estate property-type terms Condo, Multi-Family, Residential created"
