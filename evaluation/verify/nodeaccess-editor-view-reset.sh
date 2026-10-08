#!/usr/bin/env bash
# Execution RESET: force the Article 'content_editor' default grants to zero, so verify FAILS
# until the agent grants that role default VIEW access on Article. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("nodeaccess.settings");
  $g = $c->get("bundles_roles_grants");
  $g["article"]["content_editor"] = ["grant_view" => 0, "grant_update" => 0, "grant_delete" => 0];
  $c->set("bundles_roles_grants", $g)->save();
' >/dev/null 2>&1
echo "reset: article/content_editor grants all 0"
