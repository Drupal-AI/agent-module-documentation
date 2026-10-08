#!/usr/bin/env bash
# Introspection SETUP: set protected_forms check_quantity=42 and add 'Cyrillic' to allowed_scripts,
# so an agent can read back the live spam-filter settings. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c=\Drupal::configFactory()->getEditable("protected_forms.settings");
  $pf=$c->get("protected_forms") ?: [];
  $pf["check_quantity"]=42;
  $pf["allowed_scripts"]=["Currency Symbols","Latin","Miscellaneous Symbols","Cyrillic"];
  $c->set("protected_forms",$pf)->save();
' >/dev/null 2>&1
echo "setup: protected_forms.settings check_quantity=42, allowed_scripts include Cyrillic"
