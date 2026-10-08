#!/usr/bin/env bash
# Execution RESET: create vocab tc_eval_h1 + term "TC Task Term A" and place block
# tc_task_block_h1 (olivero) WITHOUT any Term visibility condition. So verify FAILS until the
# agent adds a Term condition gating the block on that term. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\taxonomy\Entity\Term;
  use Drupal\block\Entity\Block;
  if (!Vocabulary::load("tc_eval_h1")) { Vocabulary::create(["vid"=>"tc_eval_h1","name"=>"TC Eval H1"])->save(); }
  $found = \Drupal::entityTypeManager()->getStorage("taxonomy_term")->loadByProperties(["name"=>"TC Task Term A","vid"=>"tc_eval_h1"]);
  if (!$found) { Term::create(["vid"=>"tc_eval_h1","name"=>"TC Task Term A"])->save(); }
  if ($b = Block::load("tc_task_block_h1")) { $b->delete(); }
  Block::create([
    "id"=>"tc_task_block_h1","theme"=>"olivero","region"=>"content","plugin"=>"system_powered_by_block","weight"=>0,
    "settings"=>["id"=>"system_powered_by_block","label"=>"TC Task H1","label_display"=>"0"],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: block tc_task_block_h1 present with NO term condition; term 'TC Task Term A' exists"
