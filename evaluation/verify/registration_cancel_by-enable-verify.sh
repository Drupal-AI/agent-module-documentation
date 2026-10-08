#!/usr/bin/env bash
# PASS when the registration_settings for node/999602 has cancel_by set to 2030-12-31T17:00:00. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $list = \Drupal::entityTypeManager()->getStorage("registration_settings")->loadByProperties(["entity_type_id"=>"node","entity_id"=>999602]);
  $s = $list ? reset($list) : NULL;
  $v = $s ? $s->get("cancel_by")->value : NULL;
  print (($v==="2030-12-31T17:00:00")?"PASS":"FAIL")." cancel_by=".var_export($v,true)."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
