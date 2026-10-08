#!/usr/bin/env bash
# Introspection CLEANUP: delete fieldblock.settings entirely, which is the module's baseline
# (it ships no config/install; the controller then falls back to node/user/taxonomy_term) and
# rebuild the block plugin definitions. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("fieldblock.settings")->delete();
  \Drupal::service("plugin.manager.block")->clearCachedDefinitions();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
drush php:eval '
  $ids = array_keys(array_filter(\Drupal::service("plugin.manager.block")->getDefinitions(),
    fn($k) => str_starts_with($k, "fieldblock:"), ARRAY_FILTER_USE_KEY));
  sort($ids); print "cleanup: fieldblock.settings deleted, derivatives = " . implode(", ", $ids) . "\n";
' 2>/dev/null
exit 0
