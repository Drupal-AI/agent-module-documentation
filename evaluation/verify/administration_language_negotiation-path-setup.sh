#!/usr/bin/env bash
# Introspection SETUP: add a distinctive custom path '/aln-probe/*' to the module's admin
# language paths list, so an agent can inspect administration_language_negotiation.negotiation
# and confirm it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("administration_language_negotiation.negotiation");
  $paths = ["/admin", "/admin/*", "/admin*", "/node/add/*", "/node/*/edit", "/node/*/translations", "/node", "/aln-probe/*"];
  $c->set("paths", $paths)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: paths now include /aln-probe/*"
