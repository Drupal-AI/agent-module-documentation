#!/usr/bin/env bash
# Introspection CLEANUP: remove the known node created by the matching setup script and its
# node_counter row, restoring baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  foreach ($storage->loadByProperties(["title" => "Statistics Eval Popular Post"]) as $node) {
    \Drupal::database()->delete("node_counter")->condition("nid", $node->id())->execute();
    $node->delete();
  }
' 2>/dev/null
drush cr >/dev/null 2>&1
echo "cleanup: 'Statistics Eval Popular Post' node + counter removed"
