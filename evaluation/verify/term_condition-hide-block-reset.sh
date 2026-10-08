#!/usr/bin/env bash
# Execution RESET: create vocab tc_eval_h2 + term "TC Task Term B" and place block
# tc_task_block_h2 (olivero) WITHOUT any Term visibility condition. verify FAILS until the
# agent adds a NEGATED Term condition (hide the block on nodes referencing that term).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\taxonomy\Entity\Term;
  use Drupal\block\Entity\Block;
  if (!Vocabulary::load("tc_eval_h2")) { Vocabulary::create(["vid"=>"tc_eval_h2","name"=>"TC Eval H2"])->save(); }
  $found = \Drupal::entityTypeManager()->getStorage("taxonomy_term")->loadByProperties(["name"=>"TC Task Term B","vid"=>"tc_eval_h2"]);
  if (!$found) { Term::create(["vid"=>"tc_eval_h2","name"=>"TC Task Term B"])->save(); }
  if ($b = Block::load("tc_task_block_h2")) { $b->delete(); }
  Block::create([
    "id"=>"tc_task_block_h2","theme"=>"olivero","region"=>"content","plugin"=>"system_powered_by_block","weight"=>0,
    "settings"=>["id"=>"system_powered_by_block","label"=>"TC Task H2","label_display"=>"0"],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: block tc_task_block_h2 present with NO term condition; term 'TC Task Term B' exists"
