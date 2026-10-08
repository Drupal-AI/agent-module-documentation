#!/usr/bin/env bash
# Introspection SETUP: make the per-node Grants tab available for the Article content type.
# Agent reads back which content type has the Grants tab enabled. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("nodeaccess.settings");
  $a = $c->get("grants_tab_availability") ?? [];
  $a["article"] = TRUE;
  $c->set("grants_tab_availability", $a)->save();
' >/dev/null 2>&1
echo "setup: nodeaccess grants_tab_availability.article=TRUE"
