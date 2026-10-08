#!/usr/bin/env bash
# Introspection SETUP (no-op): the module is already enabled; its effect (node entity type has
# no EntityUntranslatableFields constraint) is live runtime state to be read back. Prints state.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c=\Drupal::entityTypeManager()->getDefinition("node")->getConstraints();
  print "EntityUntranslatableFields present on node: ".(isset($c["EntityUntranslatableFields"])?"YES":"NO")."\n";
' 2>/dev/null
echo "setup: (no-op) module enabled; node constraint state printed above"
