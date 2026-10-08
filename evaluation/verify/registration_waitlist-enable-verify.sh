#!/usr/bin/env bash
# PASS when reg_wl has wait-list confirmation_email=true. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $t=\Drupal\registration\Entity\RegistrationType::load("reg_wl");
  $v=$t?$t->getThirdPartySetting("registration_waitlist","confirmation_email"):NULL;
  print (($v===TRUE)?"PASS":"FAIL")." confirmation_email=".var_export($v,true)."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
