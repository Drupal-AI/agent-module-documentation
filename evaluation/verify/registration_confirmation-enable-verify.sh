#!/usr/bin/env bash
# PASS when reg_conf has confirmation enable=true. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $t=\Drupal\registration\Entity\RegistrationType::load("reg_conf");
  $v=$t?$t->getThirdPartySetting("registration_confirmation","enable"):NULL;
  print (($v===TRUE)?"PASS":"FAIL")." enable=".var_export($v,true)."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
