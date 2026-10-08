#!/usr/bin/env bash
# Introspection SETUP: cast known votes (values 60, 80, 100) of the default `vote` type on
# node 1 and recalculate, so a full set of aggregate result functions (vote_count,
# vote_average, vote_sum, vote_maximum, vote_minimum, vote_median) is stored for node 1 and
# an inspecting agent can read back which functions are stored. Idempotent. Ensures node 1.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $etm = \Drupal::entityTypeManager();
  if (!\Drupal\node\Entity\Node::load(1)) {
    $n = \Drupal\node\Entity\Node::create(["nid" => 1, "type" => "article", "title" => "Eval Voting Target Node"]);
    $n->enforceIsNew(TRUE);
    $n->save();
  }
  foreach (["vote", "vote_result"] as $et) {
    $s = $etm->getStorage($et);
    $ids = $s->getQuery()->accessCheck(FALSE)
      ->condition("type", "vote")->condition("entity_type", "node")->condition("entity_id", 1)->execute();
    if ($ids) { $s->delete($s->loadMultiple($ids)); }
  }
  $vs = $etm->getStorage("vote");
  foreach ([60, 80, 100] as $val) {
    $vs->create([
      "type" => "vote",
      "entity_type" => "node",
      "entity_id" => 1,
      "value_type" => "points",
      "value" => $val,
      "user_id" => 0,
    ])->save();
  }
  \Drupal::service("plugin.manager.votingapi.resultfunction")->recalculateResults("node", 1, "vote");
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: votes (60,80,100) cast + recalculated on node 1; result functions stored; node 1 present"
