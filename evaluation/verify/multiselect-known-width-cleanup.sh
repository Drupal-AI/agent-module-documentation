#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped default width (250). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("multiselect.settings")->set("multiselect.widths", 250)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: multiselect.settings multiselect.widths=250 (default)"
