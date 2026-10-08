#!/usr/bin/env bash
# Introspection CLEANUP: delete the "TMN Known Term" Tags term. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Term;
  foreach (\Drupal::entityQuery("taxonomy_term")->condition("vid","tags")->condition("name","TMN Known Term")->accessCheck(FALSE)->execute() as $tid) {
    Term::load($tid)->delete();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: 'TMN Known Term' removed from Tags"
