#!/usr/bin/env bash
# Execution VERIFY: PASS when field.storage.node.field_fe_task third-party setting
# field_encrypt.encrypt === TRUE. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  $fs = FieldStorageConfig::loadByName("node","field_fe_task");
  $enc = $fs ? (bool) $fs->getThirdPartySetting("field_encrypt","encrypt",FALSE) : FALSE;
  $props = $fs ? $fs->getThirdPartySetting("field_encrypt","properties",[]) : [];
  print (($enc === TRUE) ? "PASS" : "FAIL") . " encrypt=" . var_export($enc,TRUE) . " properties=" . implode(",",$props) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
