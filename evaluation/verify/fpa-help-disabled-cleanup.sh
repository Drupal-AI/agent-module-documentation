#!/usr/bin/env bash
# Introspection CLEANUP: restore fpa.settings baseline — no sections disabled
# (disabled_sections = {}), the install default. Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("fpa.settings")
    ->set("disabled_sections", [])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: fpa.settings disabled_sections restored to {} (all sections visible)"
