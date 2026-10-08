#!/usr/bin/env bash
# Execution RESET: delete any Article titled "CBC Hard Node", so verify FAILs until the agent
# creates one carrying the required body_class.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityQuery("node")->condition("title", "CBC Hard Node")->accessCheck(FALSE)->execute();
  if ($ids) { foreach (Node::loadMultiple($ids) as $n) { $n->delete(); } }
' >/dev/null 2>&1
echo "reset: no CBC Hard Node present"
