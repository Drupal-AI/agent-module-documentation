#!/usr/bin/env bash
# Introspection SETUP: place block tc_gated_block_m2 with a NEGATED Term condition referencing
# term "TC Hidden Term" (vocab tc_eval_m2), so the block is HIDDEN on matching nodes. An agent
# must inspect the live block config and report that the condition is negated. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\taxonomy\Entity\Term;
  use Drupal\block\Entity\Block;
  if (!Vocabulary::load("tc_eval_m2")) { Vocabulary::create(["vid"=>"tc_eval_m2","name"=>"TC Eval M2"])->save(); }
  $found = \Drupal::entityTypeManager()->getStorage("taxonomy_term")->loadByProperties(["name"=>"TC Hidden Term","vid"=>"tc_eval_m2"]);
  $term = $found ? reset($found) : NULL;
  if (!$term) { $term = Term::create(["vid"=>"tc_eval_m2","name"=>"TC Hidden Term"]); $term->save(); }
  if ($b = Block::load("tc_gated_block_m2")) { $b->delete(); }
  $block = Block::create([
    "id"=>"tc_gated_block_m2","theme"=>"olivero","region"=>"content","plugin"=>"system_powered_by_block","weight"=>0,
    "settings"=>["id"=>"system_powered_by_block","label"=>"TC Gated M2","label_display"=>"0"],
  ]);
  $block->setVisibilityConfig("term", [
    "id"=>"term","negate"=>TRUE,
    "context_mapping"=>["node"=>"@node.node_route_context:node"],
    "term_uuids"=>[$term->uuid()],
  ]);
  $block->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block tc_gated_block_m2 has a NEGATED Term condition on 'TC Hidden Term'"
