#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped type_tray.settings baseline. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("type_tray.settings");
  $c->clear("categories")->clear("text_format")->set("fallback_label", "Uncategorized")->save();
' >/dev/null 2>&1
echo "cleanup: type_tray.settings back to fallback_label=Uncategorized"
