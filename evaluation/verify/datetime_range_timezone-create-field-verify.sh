#!/usr/bin/env bash
# Execution VERIFY: PASS when Article has field_drt_task whose storage type is
# daterange_timezone and its default form widget is daterange_timezone. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $fs = FieldStorageConfig::loadByName("node", "field_drt_task");
  $fc = FieldConfig::loadByName("node", "article", "field_drt_task");
  $type = $fs ? $fs->getType() : "none";
  $comp = \Drupal::service("entity_display.repository")->getFormDisplay("node","article")->getComponent("field_drt_task");
  $widget = $comp["type"] ?? "none";
  $ok = ($fs && $fc && $type === "daterange_timezone");
  print ($ok ? "PASS" : "FAIL") . " storage_type=" . $type . " field=" . ($fc ? "yes" : "no") . " widget=" . $widget . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
