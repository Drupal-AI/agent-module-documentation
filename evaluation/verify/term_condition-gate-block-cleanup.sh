#!/usr/bin/env bash
# Execution CLEANUP: remove block tc_task_block_h1 and vocab tc_eval_h1 (+ terms). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\block\Entity\Block;
  if ($b = Block::load("tc_task_block_h1")) { $b->delete(); }
  foreach (\Drupal::entityTypeManager()->getStorage("taxonomy_term")->loadByProperties(["vid"=>"tc_eval_h1"]) as $t) { $t->delete(); }
  if ($v = Vocabulary::load("tc_eval_h1")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: tc_task_block_h1 and vocab tc_eval_h1 removed"
