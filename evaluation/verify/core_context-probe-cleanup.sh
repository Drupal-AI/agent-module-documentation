#!/usr/bin/env bash
# Introspection CLEANUP: remove the core_context third-party setting from the display. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $d = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $d->unsetThirdPartySetting("core_context", "contexts");
  $d->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: core_context contexts removed from node.article.default"
