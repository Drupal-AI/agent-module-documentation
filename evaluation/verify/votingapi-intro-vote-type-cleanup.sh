#!/usr/bin/env bash
# Introspection CLEANUP: remove the known eval_intro_vt vote_type (and any votes/results
# carrying it), restoring baseline. Ensures node 1 still exists. Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $etm = \Drupal::entityTypeManager();
  foreach (["vote", "vote_result"] as $et) {
    $s = $etm->getStorage($et);
    $ids = $s->getQuery()->accessCheck(FALSE)->condition("type", "eval_intro_vt")->execute();
    if ($ids) { $s->delete($s->loadMultiple($ids)); }
  }
  if ($vt = $etm->getStorage("vote_type")->load("eval_intro_vt")) { $vt->delete(); }
  if (!\Drupal\node\Entity\Node::load(1)) {
    $n = \Drupal\node\Entity\Node::create(["nid" => 1, "type" => "article", "title" => "Eval Voting Target Node"]);
    $n->enforceIsNew(TRUE);
    $n->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: vote_type eval_intro_vt removed; node 1 present"
