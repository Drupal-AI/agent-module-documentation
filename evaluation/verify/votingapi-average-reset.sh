#!/usr/bin/env bash
# Execution RESET for the "eval_avg average = 80" Voting API task: clear every vote /
# vote_result carrying the eval_avg vote type, delete the eval_avg vote_type config entity,
# and ensure a target node with id 1 exists. Leaves a clean slate so the agent must build
# the vote type, cast the three votes, and recalculate itself.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $etm = \Drupal::entityTypeManager();
  foreach (["vote", "vote_result"] as $et) {
    $s = $etm->getStorage($et);
    $ids = $s->getQuery()->accessCheck(FALSE)->condition("type", "eval_avg")->execute();
    if ($ids) { $s->delete($s->loadMultiple($ids)); }
  }
  if ($vt = $etm->getStorage("vote_type")->load("eval_avg")) { $vt->delete(); }
  if (!\Drupal\node\Entity\Node::load(1)) {
    $n = \Drupal\node\Entity\Node::create(["nid" => 1, "type" => "article", "title" => "Eval Voting Target Node"]);
    $n->enforceIsNew(TRUE);
    $n->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: eval_avg votes/results/type cleared; node 1 present"
