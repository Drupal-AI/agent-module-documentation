#!/usr/bin/env bash
# Introspection SETUP: create a known real_estate taxonomy term so an agent can read it. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Term;
  $ids = \Drupal::entityQuery("taxonomy_term")->accessCheck(FALSE)->condition("vid","real_estate")->condition("name","SGM Demo Type Alpha")->execute();
  if (!$ids) { Term::create(["vid"=>"real_estate","name"=>"SGM Demo Type Alpha"])->save(); }
' >/dev/null 2>&1
echo "setup: taxonomy term 'SGM Demo Type Alpha' in vocabulary real_estate created"
