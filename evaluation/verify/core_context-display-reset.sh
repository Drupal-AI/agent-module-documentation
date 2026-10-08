#!/usr/bin/env bash
# Execution RESET: ensure the node.article.default display has NO core_context context, so verify
# fails until the agent attaches one. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $d = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $d->unsetThirdPartySetting("core_context", "contexts");
  $d->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: no core_context context on node.article.default"
