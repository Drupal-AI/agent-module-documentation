#!/usr/bin/env bash
# Execution VERIFY (serial H1): PASS when Article has a field field_srl_task of type 'serial'
# with storage setting start_value == 500. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $fs = FieldStorageConfig::loadByName("node","field_srl_task");
  $fc = FieldConfig::loadByName("node","article","field_srl_task");
  $type = $fs ? $fs->getType() : "none";
  $start = $fs ? (int) $fs->getSetting("start_value") : -1;
  $ok = $fs && $fc && $type === "serial" && $start === 500;
  print ($ok ? "PASS" : "FAIL")." type=".$type." start_value=".$start."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
