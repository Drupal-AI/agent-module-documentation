#!/usr/bin/env bash
# Introspection SETUP: guarantee the convert_bundles action for the node entity type exists
# (it is auto-created on install for every entity type with 2+ bundles). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Action;
  if (!Action::load("convert_bundles_on_node")) {
    Action::create([
      "id" => "convert_bundles_on_node", "label" => "Convert Content Entity Bundles",
      "type" => "node", "configuration" => [], "plugin" => "convert_bundles_action_base",
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: system.action.convert_bundles_on_node present (plugin convert_bundles_action_base)"
