#!/usr/bin/env bash
# Introspection SETUP: configure activities to log node create + update (not delete/view) so an
# inspecting agent can read which operations are tracked for nodes. Baseline: activities.settings
# is absent (nothing logged). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("activities.settings");
  $c->set("node", ["create"=>"create","update"=>"update","delete"=>0,"view"=>0])->save();
' >/dev/null 2>&1
echo "setup: activities.settings node logs create+update"
