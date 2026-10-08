#!/usr/bin/env bash
# Introspection CLEANUP: delete the PC Alpha / PC Beta nodes and rebuild node access. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\Node;
  foreach (["PC Alpha","PC Beta"] as $title) {
    foreach (\Drupal::entityQuery("node")->condition("title",$title)->accessCheck(FALSE)->execute() as $nid) { Node::load($nid)->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: PC Alpha / PC Beta removed"
