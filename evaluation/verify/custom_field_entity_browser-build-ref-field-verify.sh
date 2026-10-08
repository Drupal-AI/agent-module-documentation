#!/usr/bin/env bash
# Execution VERIFY: PASS when field_cfeb_ref is custom with an entity_reference column 'ref'
# target_type node, instanced on cfeb_eval.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $fs=FieldStorageConfig::loadByName("node","field_cfeb_ref");
  $fc=FieldConfig::loadByName("node","cfeb_eval","field_cfeb_ref");
  $cols=$fs?($fs->getSetting("columns")??[]):[];
  $t=$cols["ref"]["type"]??NULL; $tt=$cols["ref"]["target_type"]??NULL;
  $ok=($fs && $fs->getType()==="custom" && $fc && $t==="entity_reference" && $tt==="node");
  print ($ok?"PASS":"FAIL")." type=".($fs?$fs->getType():"none")." ref=".var_export($t,true)." target=".var_export($tt,true)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
