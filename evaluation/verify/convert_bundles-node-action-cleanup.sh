#!/usr/bin/env bash
# Introspection CLEANUP: the node convert action is a shipped default (recreated on install),
# so baseline is "present". Ensure it exists. Idempotent. Exit 0.
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
echo "cleanup: convert_bundles_on_node ensured present (baseline)"
