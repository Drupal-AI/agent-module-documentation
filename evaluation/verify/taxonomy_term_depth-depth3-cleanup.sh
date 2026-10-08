#!/usr/bin/env bash
# Introspection CLEANUP: delete vocab ttd_eval_m and its terms. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  foreach(\Drupal::entityTypeManager()->getStorage("taxonomy_term")->loadByProperties(["vid"=>"ttd_eval_m"]) as $t){$t->delete();}
  if ($v=Vocabulary::load("ttd_eval_m")) { $v->delete(); }
' >/dev/null 2>&1
echo "cleanup: vocab ttd_eval_m removed"
