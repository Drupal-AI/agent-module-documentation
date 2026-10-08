#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  if ($v = Vocabulary::load("flattax_tree")) {
    foreach (\Drupal::entityTypeManager()->getStorage("taxonomy_term")->loadByProperties(["vid"=>"flattax_tree"]) as $t) { $t->delete(); }
    $v->delete();
  }
' >/dev/null 2>&1
echo "cleanup: vocabulary flattax_tree and its terms removed"
