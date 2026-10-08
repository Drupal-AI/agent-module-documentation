#!/usr/bin/env bash
# Execution RESET: force the Article 'author' default grants to all zero (esp. grant_update=0),
# so verify FAILS until the agent grants authors edit access by default. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("nodeaccess.settings");
  $g = $c->get("bundles_roles_grants");
  $g["article"]["author"] = ["grant_view" => 0, "grant_update" => 0, "grant_delete" => 0];
  $c->set("bundles_roles_grants", $g)->save();
' >/dev/null 2>&1
echo "reset: article/author grants all 0"
