#!/usr/bin/env bash
# Introspection CLEANUP: remove block tc_gated_block_m2 and vocab tc_eval_m2 (+ terms). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\block\Entity\Block;
  if ($b = Block::load("tc_gated_block_m2")) { $b->delete(); }
  foreach (\Drupal::entityTypeManager()->getStorage("taxonomy_term")->loadByProperties(["vid"=>"tc_eval_m2"]) as $t) { $t->delete(); }
  if ($v = Vocabulary::load("tc_eval_m2")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: tc_gated_block_m2 and vocab tc_eval_m2 removed"
