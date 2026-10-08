#!/usr/bin/env bash
# Introspection CLEANUP: delete the IV Probe Landing node and the iv_tag text format.
# Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $node_storage = \Drupal::entityTypeManager()->getStorage("node");
  foreach ($node_storage->loadByProperties(["title" => "IV Probe Landing"]) as $node) { $node->delete(); }
  if ($f = \Drupal::entityTypeManager()->getStorage("filter_format")->load("iv_tag")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: node 'IV Probe Landing' and text format iv_tag removed"
