#!/usr/bin/env bash
# Execution VERIFY: PASS when Article has a field_fu_task field whose storage type is file_url
# and its default form-display widget is file_url_generic. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $fs = FieldStorageConfig::loadByName("node", "field_fu_task");
  $fc = FieldConfig::loadByName("node", "article", "field_fu_task");
  $type = $fs ? $fs->getType() : "none";
  $comp = \Drupal::service("entity_display.repository")->getFormDisplay("node","article")->getComponent("field_fu_task");
  $widget = $comp["type"] ?? "none";
  $ok = ($fs && $fc && $type === "file_url");
  print ($ok ? "PASS" : "FAIL") . " storage_type=" . $type . " field=" . ($fc ? "yes" : "no") . " widget=" . $widget . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
