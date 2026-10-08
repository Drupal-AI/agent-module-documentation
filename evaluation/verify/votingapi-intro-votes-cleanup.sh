#!/usr/bin/env bash
# Introspection CLEANUP: delete the default-type votes/results cast on node 1 by the matching
# setup, restoring baseline. Ensures node 1 still exists. Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $etm = \Drupal::entityTypeManager();
  foreach (["vote", "vote_result"] as $et) {
    $s = $etm->getStorage($et);
    $ids = $s->getQuery()->accessCheck(FALSE)
      ->condition("type", "vote")->condition("entity_type", "node")->condition("entity_id", 1)->execute();
    if ($ids) { $s->delete($s->loadMultiple($ids)); }
  }
  if (!\Drupal\node\Entity\Node::load(1)) {
    $n = \Drupal\node\Entity\Node::create(["nid" => 1, "type" => "article", "title" => "Eval Voting Target Node"]);
    $n->enforceIsNew(TRUE);
    $n->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: default-type votes/results on node 1 removed; node 1 present"
