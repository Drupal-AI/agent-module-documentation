#!/usr/bin/env bash
# Introspection SETUP: create vocab tc_eval_m1 + term "TC Gate Term", place block
# tc_gated_block_m1 (olivero) with a Term visibility condition referencing that term, so an
# inspecting agent can read the block config, resolve the term UUID and name the term.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\taxonomy\Entity\Term;
  use Drupal\block\Entity\Block;
  if (!Vocabulary::load("tc_eval_m1")) { Vocabulary::create(["vid"=>"tc_eval_m1","name"=>"TC Eval M1"])->save(); }
  $found = \Drupal::entityTypeManager()->getStorage("taxonomy_term")->loadByProperties(["name"=>"TC Gate Term","vid"=>"tc_eval_m1"]);
  $term = $found ? reset($found) : NULL;
  if (!$term) { $term = Term::create(["vid"=>"tc_eval_m1","name"=>"TC Gate Term"]); $term->save(); }
  if ($b = Block::load("tc_gated_block_m1")) { $b->delete(); }
  $block = Block::create([
    "id"=>"tc_gated_block_m1","theme"=>"olivero","region"=>"content","plugin"=>"system_powered_by_block","weight"=>0,
    "settings"=>["id"=>"system_powered_by_block","label"=>"TC Gated M1","label_display"=>"0"],
  ]);
  $block->setVisibilityConfig("term", [
    "id"=>"term","negate"=>FALSE,
    "context_mapping"=>["node"=>"@node.node_route_context:node"],
    "term_uuids"=>[$term->uuid()],
  ]);
  $block->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block tc_gated_block_m1 gated by term 'TC Gate Term' (vocab tc_eval_m1)"
