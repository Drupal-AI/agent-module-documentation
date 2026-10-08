#!/usr/bin/env bash
# Introspection SETUP: enable Revision Manager for the node and taxonomy_term entity types, so
# an agent can inspect the config and report which entity types are managed. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("revision_manager.settings");
  $c->set("enabled_entities", ["node" => TRUE, "taxonomy_term" => TRUE]);
  $c->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: revision_manager enabled_entities = node, taxonomy_term"
