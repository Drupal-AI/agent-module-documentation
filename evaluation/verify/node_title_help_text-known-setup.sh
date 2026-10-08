#!/usr/bin/env bash
# Introspection SETUP: create content type nthht_known and set node_title_help_text title_help
# to a known string, so an agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  $t = NodeType::load("nthht_known") ?: NodeType::create(["type"=>"nthht_known","name"=>"NTHHT Known"]);
  $t->save();
  $t->setThirdPartySetting("node_title_help_text","title_help","Enter the official product name, e.g. Widget Pro 3000.");
  $t->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.type.nthht_known title_help set"
