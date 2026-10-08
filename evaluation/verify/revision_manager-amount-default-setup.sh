#!/usr/bin/env bash
# Introspection SETUP: enable Revision Manager for nodes with the Amount plugin set to keep the
# newest 7 revisions, so an agent can read back the configured minimum count. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("revision_manager.settings");
  $c->set("enabled_entities", ["node" => TRUE]);
  $c->set("defaults", ["node" => ["amount" => ["id" => "amount", "status" => TRUE, "settings" => ["amount" => 7]]]]);
  $c->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: revision_manager node Amount keep=7"
