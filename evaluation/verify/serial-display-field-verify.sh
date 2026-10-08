#!/usr/bin/env bash
# Execution VERIFY (serial H2): PASS when Article has a serial field field_srl_evt AND it is
# shown on the default view display using the serial_default_formatter. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  $fs = FieldStorageConfig::loadByName("node","field_srl_evt");
  $isSerial = $fs && $fs->getType() === "serial";
  $vd = \Drupal::service("entity_display.repository")->getViewDisplay("node","article","default");
  $c = $vd ? $vd->getComponent("field_srl_evt") : NULL;
  $fmt = $c["type"] ?? "none";
  $ok = $isSerial && $fmt === "serial_default_formatter";
  print ($ok ? "PASS" : "FAIL")." serial=".var_export($isSerial,TRUE)." formatter=".$fmt."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
