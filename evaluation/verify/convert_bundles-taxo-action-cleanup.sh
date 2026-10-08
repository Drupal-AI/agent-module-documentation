#!/usr/bin/env bash
# Introspection CLEANUP: taxonomy_term convert action is a shipped default; ensure present.
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
echo "cleanup: convert_bundles_on_taxonomy_term ensured present (baseline)"
