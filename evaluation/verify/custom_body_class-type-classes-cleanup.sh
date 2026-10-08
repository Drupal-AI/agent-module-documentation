#!/usr/bin/env bash
# Introspection CLEANUP: remove the Article third-party classes setting. Restores baseline.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $t = \Drupal::entityTypeManager()->getStorage("node_type")->load("article");
  $t->unsetThirdPartySetting("custom_body_class", "classes");
  $t->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: article custom_body_class.classes unset"
