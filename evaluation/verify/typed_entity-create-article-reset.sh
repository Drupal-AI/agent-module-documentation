#!/usr/bin/env bash
# Execution RESET: ensure typed_entity_example is enabled (so the node.article repository
# exists) and delete any leftover probe article, so verify FAILS until the agent creates it.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en typed_entity_example -y >/dev/null 2>&1
drush php:eval '
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)->condition("title","TE Article Probe")->execute();
  foreach (\Drupal\node\Entity\Node::loadMultiple($ids) as $n) { $n->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: typed_entity_example enabled; no node titled 'TE Article Probe'"
