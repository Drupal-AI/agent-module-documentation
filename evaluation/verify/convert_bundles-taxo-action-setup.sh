#!/usr/bin/env bash
# Introspection SETUP: guarantee the convert_bundles action for taxonomy_term exists so the
# agent can discover its config-entity id. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\system\Entity\Action;
  if (!Action::load("convert_bundles_on_taxonomy_term")) {
    Action::create([
      "id" => "convert_bundles_on_taxonomy_term", "label" => "Convert Taxonomy term Entity Bundles",
      "type" => "taxonomy_term", "configuration" => [], "plugin" => "convert_bundles_action_base",
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: system.action.convert_bundles_on_taxonomy_term present"
