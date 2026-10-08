#!/usr/bin/env bash
# Execution RESET: remove any Tags term named "TMN Explicit Term" and any term whose
# machine_name is tmn_custom_slug, so verify FAILS until the agent creates the term with that
# explicit machine name. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Term;
  foreach (\Drupal::entityQuery("taxonomy_term")->condition("vid","tags")->condition("name","TMN Explicit Term")->accessCheck(FALSE)->execute() as $tid) { Term::load($tid)->delete(); }
  foreach (\Drupal::entityTypeManager()->getStorage("taxonomy_term")->loadByProperties(["vid"=>"tags","machine_name"=>"tmn_custom_slug"]) as $t) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: no Tags term named 'TMN Explicit Term' / machine_name tmn_custom_slug"
