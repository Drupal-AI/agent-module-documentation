#!/usr/bin/env bash
# Execution VERIFY: PASS when node.article field_spn_task is type sms_phone_number with verify==required. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("node","article","field_spn_task");
  $type = $fc ? $fc->getType() : "none";
  $verify = $fc ? $fc->getSetting("verify") : NULL;
  $ok = $fc && ($type==="sms_phone_number") && ($verify==="required");
  print ($ok?"PASS":"FAIL")." type=".$type." verify=".var_export($verify,TRUE)."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
