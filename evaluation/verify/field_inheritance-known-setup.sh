#!/usr/bin/env bash
# Introspection SETUP: create a known field_inheritance config entity (fi_known) that inherits the
# article body into the page bundle, so an inspecting agent can read back what it inherits.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field_inheritance\Entity\FieldInheritance;
  if ($e = FieldInheritance::load("node_page_fi_known")) { $e->delete(); }
  FieldInheritance::create([
    "id" => "fi_known", "label" => "FI Known", "type" => "inherit",
    "sourceEntityType" => "node", "sourceEntityBundle" => "article", "sourceField" => "body",
    "destinationEntityType" => "node", "destinationEntityBundle" => "page",
    "plugin" => "default_inheritance",
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field inheritance node_page_fi_known (source node/article/body -> node/page, inherit)"
