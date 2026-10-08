#!/usr/bin/env bash
# Execution VERIFY: PASS when field_cf_task is a `custom` field on cf_eval whose storage columns
# include title(string) and score(integer). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $fs = FieldStorageConfig::loadByName("node","field_cf_task");
  $fc = FieldConfig::loadByName("node","cf_eval","field_cf_task");
  $cols = $fs ? ($fs->getSetting("columns") ?? []) : [];
  $t = $cols["title"]["type"] ?? NULL;
  $s = $cols["score"]["type"] ?? NULL;
  $ok = ($fs && $fs->getType()==="custom" && $fc && $t==="string" && $s==="integer");
  print ($ok?"PASS":"FAIL")." type=".($fs?$fs->getType():"none")." title=".var_export($t,true)." score=".var_export($s,true)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
