#!/usr/bin/env bash
# Introspection SETUP: give the anonymous role a default VIEW grant on the Article content type
# in nodeaccess.settings, so an agent can read back which role has it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("nodeaccess.settings");
  $g = $c->get("bundles_roles_grants");
  $g["article"]["anonymous"] = ["grant_view" => 1, "grant_update" => 0, "grant_delete" => 0];
  $c->set("bundles_roles_grants", $g)->save();
' >/dev/null 2>&1
echo "setup: nodeaccess bundles_roles_grants.article.anonymous.grant_view=1"
