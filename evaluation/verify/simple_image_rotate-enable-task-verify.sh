#!/usr/bin/env bash
# Execution VERIFY: PASS when field_sir_task FieldConfig has enable_rotate === TRUE. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("node","article","field_sir_task");
  $v = $fc ? $fc->getThirdPartySetting("simple_image_rotate","enable_rotate") : NULL;
  $ok = ($v === TRUE);
  print ($ok?"PASS":"FAIL")." field_sir_task enable_rotate=".var_export($v,TRUE)."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
