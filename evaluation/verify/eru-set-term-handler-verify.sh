#!/usr/bin/env bash
# Execution VERIFY: PASS when field_config field_eru_vocab settings.handler === unpublished_taxonomy_term. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc=FieldConfig::loadByName("node","article","field_eru_vocab");
  $h=$fc?$fc->getSetting("handler"):NULL;
  print (($h==="unpublished_taxonomy_term")?"PASS":"FAIL")." handler=".var_export($h,TRUE)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
