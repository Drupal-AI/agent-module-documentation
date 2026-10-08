#!/usr/bin/env bash
# PASS when reg_ovr enables the "close" admin override (register after close). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $t = \Drupal\registration\Entity\RegistrationType::load("reg_ovr");
  $v = $t ? $t->getThirdPartySetting("registration_admin_overrides","close") : NULL;
  print (($v===TRUE)?"PASS":"FAIL")." close=".var_export($v,true)."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
