#!/usr/bin/env bash
# Introspection SETUP: save fieldblock.settings with a non-default enabled_entity_types list
# (node + media only — user and taxonomy_term switched off) and rebuild the block plugin
# definitions, so the live derivative list really changes. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("fieldblock.settings")
    ->set("enabled_entity_types", ["node" => "node", "media" => "media"])
    ->save();
  \Drupal::service("plugin.manager.block")->clearCachedDefinitions();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
drush php:eval '
  $ids = array_keys(array_filter(\Drupal::service("plugin.manager.block")->getDefinitions(),
    fn($k) => str_starts_with($k, "fieldblock:"), ARRAY_FILTER_USE_KEY));
  sort($ids); print "setup: derivatives = " . implode(", ", $ids) . "\n";
' 2>/dev/null
exit 0
