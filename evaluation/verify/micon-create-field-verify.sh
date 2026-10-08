#!/usr/bin/env bash
# Execution VERIFY: PASS when field_micon_task exists as a string_micon field on node.article
# and its default form-display component uses the string_micon widget. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $fs = FieldStorageConfig::loadByName("node","field_micon_task");
  $fc = FieldConfig::loadByName("node","article","field_micon_task");
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node","article","default");
  $c = $fd ? $fd->getComponent("field_micon_task") : NULL;
  $ok = $fs && $fs->getType()==="string_micon" && $fc && $c && ($c["type"] ?? "")==="string_micon";
  print ($ok ? "PASS" : "FAIL") . " storage=" . ($fs ? $fs->getType() : "none") . " widget=" . ($c["type"] ?? "none") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
