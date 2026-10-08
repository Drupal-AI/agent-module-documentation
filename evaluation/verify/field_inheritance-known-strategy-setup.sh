#!/usr/bin/env bash
# Introspection SETUP: create inheritance fi_strat using the 'append' strategy (source node/article
# body, dest node/page, destinationField body). Reads back its strategy. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field_inheritance\Entity\FieldInheritance;
  if ($e = FieldInheritance::load("node_page_fi_strat")) { $e->delete(); }
  FieldInheritance::create([
    "id" => "fi_strat", "label" => "FI Strat", "type" => "append",
    "sourceEntityType" => "node", "sourceEntityBundle" => "article", "sourceField" => "body",
    "destinationEntityType" => "node", "destinationEntityBundle" => "page", "destinationField" => "body",
    "plugin" => "default_inheritance",
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field inheritance node_page_fi_strat (type=append)"
