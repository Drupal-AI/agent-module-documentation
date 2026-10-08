#!/usr/bin/env bash
# Execution RESET for the replicate_ui "clone a node" hard case.
# Establishes a single known source node the agent must duplicate:
#   - deletes every node whose title starts with "Replicate Eval Source" (any leftover
#     source or prior clones), then
#   - creates exactly ONE article titled "Replicate Eval Source".
# After this exactly one such node exists, so verify (which passes on >= 2) FAILs until
# the agent clones it via replicate.replicator.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  $ids = $storage->getQuery()->accessCheck(FALSE)
    ->condition("title", "Replicate Eval Source%", "LIKE")->execute();
  if ($ids) { $storage->delete($storage->loadMultiple($ids)); }
  $n = \Drupal\node\Entity\Node::create(["type" => "article", "title" => "Replicate Eval Source"]);
  $n->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: one source article 'Replicate Eval Source' created; clones cleared"
