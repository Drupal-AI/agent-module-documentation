#!/usr/bin/env bash
# Reset Voting API to a clean, known baseline between eval runs so each condition is
# independent: delete every vote / vote_result entity attached to (node, 1) or carrying
# the eval_rating vote type, delete the eval_rating vote_type config entity if present,
# and ensure a target Article node with id 1 exists (create it if the site has none).
set -uo pipefail
cd /var/www/html
drush php:eval '
  $etm = \Drupal::entityTypeManager();
  // Delete raw votes and aggregate results for node 1.
  foreach (["vote", "vote_result"] as $et) {
    $storage = $etm->getStorage($et);
    $ids = $storage->getQuery()->accessCheck(FALSE)
      ->condition("entity_type", "node")->condition("entity_id", 1)->execute();
    if ($ids) { $storage->delete($storage->loadMultiple($ids)); }
    // Anything else carrying the eval_rating vote type.
    $ids2 = $storage->getQuery()->accessCheck(FALSE)->condition("type", "eval_rating")->execute();
    if ($ids2) { $storage->delete($storage->loadMultiple($ids2)); }
  }
  // Drop the eval_rating vote type (config entity / bundle) if it exists.
  if ($vt = $etm->getStorage("vote_type")->load("eval_rating")) { $vt->delete(); }
  // Ensure a known Article node with id 1 exists as the vote target.
  if (!\Drupal\node\Entity\Node::load(1)) {
    $n = \Drupal\node\Entity\Node::create(["nid" => 1, "type" => "article", "title" => "Eval Voting Target Node"]);
    $n->enforceIsNew(TRUE);
    $n->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: eval_rating votes/results/type cleared; node 1 present"
