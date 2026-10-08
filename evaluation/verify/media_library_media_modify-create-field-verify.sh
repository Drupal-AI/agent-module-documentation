#!/usr/bin/env bash
# Execution VERIFY: PASS when Article has a field_mlmm_task whose storage type is
# entity_reference_entity_modify AND whose default form-display component uses the
# media_library_media_modify_widget. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  $fs = FieldStorageConfig::loadByName("node", "field_mlmm_task");
  $type = $fs ? $fs->getType() : "none";
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node", "article", "default");
  $c = $fd ? $fd->getComponent("field_mlmm_task") : NULL;
  $widget = $c["type"] ?? "none";
  $ok = ($type === "entity_reference_entity_modify" && $widget === "media_library_media_modify_widget");
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " widget=" . $widget . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
