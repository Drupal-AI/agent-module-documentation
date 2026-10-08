#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("nodeaccess.settings");
  $g = $c->get("bundles_roles_grants");
  $g["article"]["author"] = ["grant_view" => 0, "grant_update" => 0, "grant_delete" => 0];
  $c->set("bundles_roles_grants", $g)->save();
' >/dev/null 2>&1
echo "cleanup: article/author grants reset to 0"
