#!/usr/bin/env bash
# CLEANUP: restore article/anonymous grants to baseline (all zeros). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("nodeaccess.settings");
  $g = $c->get("bundles_roles_grants");
  $g["article"]["anonymous"] = ["grant_view" => 0, "grant_update" => 0, "grant_delete" => 0];
  $c->set("bundles_roles_grants", $g)->save();
' >/dev/null 2>&1
echo "cleanup: article/anonymous grants reset to 0"
