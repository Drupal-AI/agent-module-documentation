#!/usr/bin/env bash
# Execution CLEANUP: delete the task node and its history rows. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)->condition("title", "History Task Node")->execute();
  if ($ids) { \Drupal::database()->delete("history")->condition("nid", $ids, "IN")->execute(); }
  foreach (Node::loadMultiple($ids) as $n) { $n->delete(); }
' >/dev/null 2>&1
echo "cleanup: History Task Node and its {history} rows removed"
