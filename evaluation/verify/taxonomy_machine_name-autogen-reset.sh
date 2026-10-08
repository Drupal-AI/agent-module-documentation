#!/usr/bin/env bash
# Execution RESET: remove any Tags term named "TMN Product Launch 2026" (and any term whose
# machine_name is tmn_product_launch_2026), so verify FAILS until the agent creates the term
# and lets taxonomy_machine_name auto-generate its machine name. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Term;
  $ids = \Drupal::entityQuery("taxonomy_term")->condition("vid","tags")
    ->condition("name","TMN Product Launch 2026")->accessCheck(FALSE)->execute();
  foreach ($ids as $tid) { Term::load($tid)->delete(); }
  foreach (\Drupal::entityTypeManager()->getStorage("taxonomy_term")->loadByProperties(["vid"=>"tags","machine_name"=>"tmn_product_launch_2026"]) as $t) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: no Tags term named 'TMN Product Launch 2026' / machine_name tmn_product_launch_2026"
