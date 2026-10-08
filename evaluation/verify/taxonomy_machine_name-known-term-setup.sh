#!/usr/bin/env bash
# Introspection SETUP: create a term in the Tags vocabulary named "TMN Known Term". The
# taxonomy_machine_name module auto-generates its machine_name (tmn_known_term) on presave, so
# an inspecting agent can read the machine_name property back. Idempotent (removes any prior
# copy first). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Term;
  foreach (\Drupal::entityQuery("taxonomy_term")->condition("vid","tags")->condition("name","TMN Known Term")->accessCheck(FALSE)->execute() as $tid) {
    Term::load($tid)->delete();
  }
  Term::create(["vid"=>"tags","name"=>"TMN Known Term"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: Tags term 'TMN Known Term' created (machine_name auto-generated)"
