#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped default paths list (drop /aln-probe/*).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("administration_language_negotiation.negotiation");
  $c->set("paths", ["/admin", "/admin/*", "/admin*", "/node/add/*", "/node/*/edit", "/node/*/translations", "/node"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: paths restored to shipped default"
