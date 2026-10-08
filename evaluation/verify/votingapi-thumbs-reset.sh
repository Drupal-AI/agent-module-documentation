#!/usr/bin/env bash
# Execution RESET for the "eval_thumbs thumbs-up" Voting API task: clear every vote /
# vote_result carrying the eval_thumbs vote type or attached to (node,1) with that type,
# delete the eval_thumbs vote_type config entity, and ensure a target node with id 1 exists.
# Leaves a clean slate so the agent must build the vote type and cast the vote itself.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $etm = \Drupal::entityTypeManager();
  foreach (["vote", "vote_result"] as $et) {
    $s = $etm->getStorage($et);
    $ids = $s->getQuery()->accessCheck(FALSE)->condition("type", "eval_thumbs")->execute();
    if ($ids) { $s->delete($s->loadMultiple($ids)); }
  }
  if ($vt = $etm->getStorage("vote_type")->load("eval_thumbs")) { $vt->delete(); }
  if (!\Drupal\node\Entity\Node::load(1)) {
    $n = \Drupal\node\Entity\Node::create(["nid" => 1, "type" => "article", "title" => "Eval Voting Target Node"]);
    $n->enforceIsNew(TRUE);
    $n->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: eval_thumbs votes/results/type cleared; node 1 present"
