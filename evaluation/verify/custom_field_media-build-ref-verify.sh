#!/usr/bin/env bash
# Execution VERIFY: PASS when field_cfmedia_task is a custom field on cfmedia_eval with an
# entity_reference column targeting media. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $fs = FieldStorageConfig::loadByName("node","field_cfmedia_task");
  $fc = FieldConfig::loadByName("node","cfmedia_eval","field_cfmedia_task");
  $cols = $fs ? ($fs->getSetting("columns") ?? []) : [];
  $hit = NULL;
  foreach ($cols as $c) { if (($c["type"] ?? "")==="entity_reference" && ($c["target_type"] ?? "")==="media") { $hit = $c["name"]; } }
  $ok = ($fs && $fs->getType()==="custom" && $fc && $hit !== NULL);
  print ($ok?"PASS":"FAIL")." type=".($fs?$fs->getType():"none")." media_ref_col=".var_export($hit,true)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
