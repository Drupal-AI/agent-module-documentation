#!/usr/bin/env bash
# Introspection SETUP: cast three KNOWN votes (values 10, 20, 90) of the default `vote` type
# on node 1 as anonymous, so an inspecting agent can read back the count (3) and average (40).
# Idempotent: clears any prior `vote` votes/results on node 1 first. Ensures node 1. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $etm = \Drupal::entityTypeManager();
  if (!\Drupal\node\Entity\Node::load(1)) {
    $n = \Drupal\node\Entity\Node::create(["nid" => 1, "type" => "article", "title" => "Eval Voting Target Node"]);
    $n->enforceIsNew(TRUE);
    $n->save();
  }
  // Clear prior default-type votes/results on node 1 so the count/average are exactly known.
  foreach (["vote", "vote_result"] as $et) {
    $s = $etm->getStorage($et);
    $ids = $s->getQuery()->accessCheck(FALSE)
      ->condition("type", "vote")->condition("entity_type", "node")->condition("entity_id", 1)->execute();
    if ($ids) { $s->delete($s->loadMultiple($ids)); }
  }
  $vs = $etm->getStorage("vote");
  foreach ([10, 20, 90] as $val) {
    $v = $vs->create([
      "type" => "vote",
      "entity_type" => "node",
      "entity_id" => 1,
      "value_type" => "points",
      "value" => $val,
      "user_id" => 0,
    ]);
    $v->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: 3 votes (10,20,90) of type vote cast on node 1 (count=3, average=40); node 1 present"
