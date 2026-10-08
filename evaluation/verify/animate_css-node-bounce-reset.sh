#!/usr/bin/env bash
# Execution RESET: delete any Article nodes titled 'animate_css_bounce*' so verify FAILs on empty
# state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $ids = \Drupal::entityTypeManager()->getStorage("node")->getQuery()->accessCheck(FALSE)
    ->condition("title", "animate_css_bounce%", "LIKE")->execute();
  if ($ids) { foreach (\Drupal\node\Entity\Node::loadMultiple($ids) as $n) { $n->delete(); } }
' >/dev/null 2>&1
echo "reset: removed animate_css_bounce* nodes"
