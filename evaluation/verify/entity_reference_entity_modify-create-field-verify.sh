#!/usr/bin/env bash
# Execution VERIFY: PASS when Article has field_eref_task with storage type
# entity_reference_entity_modify AND its default form-display component uses the
# entity_reference_autocomplete_with_override widget. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  $fs = FieldStorageConfig::loadByName("node", "field_eref_task");
  $type = $fs ? $fs->getType() : "none";
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node", "article", "default");
  $c = $fd ? $fd->getComponent("field_eref_task") : NULL;
  $widget = $c["type"] ?? "none";
  $ok = ($type === "entity_reference_entity_modify" && $widget === "entity_reference_autocomplete_with_override");
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " widget=" . $widget . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
