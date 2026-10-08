#!/usr/bin/env bash
# Execution CLEANUP: delete vocab ttd_eval_h2 and its terms. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  foreach(\Drupal::entityTypeManager()->getStorage("taxonomy_term")->loadByProperties(["vid"=>"ttd_eval_h2"]) as $t){$t->delete();}
  if ($v=Vocabulary::load("ttd_eval_h2")) { $v->delete(); }
' >/dev/null 2>&1
echo "cleanup: vocab ttd_eval_h2 removed"
