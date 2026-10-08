#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped defaults for the keys the setup changed
# (check_quantity=50, allowed_scripts= the three shipped defaults). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c=\Drupal::configFactory()->getEditable("protected_forms.settings");
  $pf=$c->get("protected_forms") ?: [];
  $pf["check_quantity"]=50;
  $pf["allowed_scripts"]=["Currency Symbols","Latin","Miscellaneous Symbols"];
  $c->set("protected_forms",$pf)->save();
' >/dev/null 2>&1
echo "cleanup: protected_forms.settings check_quantity=50, allowed_scripts restored to shipped defaults"
