#!/usr/bin/env bash
# Introspection CLEANUP: delete the two Tags terms created by the matching setup. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Term;
  foreach (["TMN Alpha One","TMN Beta Two"] as $name) {
    foreach (\Drupal::entityQuery("taxonomy_term")->condition("vid","tags")->condition("name",$name)->accessCheck(FALSE)->execute() as $tid) { Term::load($tid)->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: 'TMN Alpha One' and 'TMN Beta Two' removed from Tags"
