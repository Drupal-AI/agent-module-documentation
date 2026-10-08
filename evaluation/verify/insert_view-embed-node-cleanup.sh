#!/usr/bin/env bash
# Execution CLEANUP: delete the IV Embed Task node and the iv_embed text format. Idempotent.
# Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "IV Embed Task"]) as $node) { $node->delete(); }
  if ($f = \Drupal::entityTypeManager()->getStorage("filter_format")->load("iv_embed")) { $f->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: node 'IV Embed Task' and text format iv_embed removed"
