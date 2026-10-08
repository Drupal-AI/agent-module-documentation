#!/usr/bin/env bash
# PASS when purge_registration_on_update === true. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v=\Drupal::config("registration_purger.settings")->get("purge_registration_on_update");
  print (($v===TRUE)?"PASS":"FAIL")." purge_registration_on_update=".var_export($v,true)."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
