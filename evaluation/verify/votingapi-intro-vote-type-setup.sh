#!/usr/bin/env bash
# Introspection SETUP: install a KNOWN vote_type config entity `eval_intro_vt` whose value
# type is "percent" so an inspecting agent can read the value type back off the live site.
# Idempotent: recreates the type if it already exists. Ensures node 1 exists. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $etm = \Drupal::entityTypeManager();
  $storage = $etm->getStorage("vote_type");
  if ($vt = $storage->load("eval_intro_vt")) { $vt->delete(); }
  $storage->create([
    "id" => "eval_intro_vt",
    "label" => "Eval Intro Vote Type",
    "value_type" => "percent",
  ])->save();
  if (!\Drupal\node\Entity\Node::load(1)) {
    $n = \Drupal\node\Entity\Node::create(["nid" => 1, "type" => "article", "title" => "Eval Voting Target Node"]);
    $n->enforceIsNew(TRUE);
    $n->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: vote_type eval_intro_vt installed (value_type = percent); node 1 present"
