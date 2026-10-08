#!/usr/bin/env bash
# Execution CLEANUP: restore excluded_forms to the shipped default trio. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c=\Drupal::configFactory()->getEditable("protected_forms.settings");
  $pf=$c->get("protected_forms") ?: [];
  $pf["excluded_forms"]=["user_login_form","user_register_form","user_pass"];
  $c->set("protected_forms",$pf)->save();
' >/dev/null 2>&1
echo "cleanup: protected_forms.settings excluded_forms restored to shipped defaults"
