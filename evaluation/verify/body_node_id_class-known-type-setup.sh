#!/usr/bin/env bash
# Introspection SETUP: add content type bnic_metrics so an agent can inspect the site and state
# the page-node-type-<bundle> body class body_node_id_class will add to its node pages.
# No nodes are created. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  if (!NodeType::load("bnic_metrics")) { NodeType::create(["type" => "bnic_metrics", "name" => "BNIC Metrics"])->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: content type bnic_metrics added"
