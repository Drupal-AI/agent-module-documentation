#!/usr/bin/env bash
# Execution VERIFY: PASS when Article has a field_jf_task field whose storage type is
# json_native AND whose default form display component uses the json_textarea widget.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $fs = FieldStorageConfig::loadByName("node", "field_jf_task");
  $fc = FieldConfig::loadByName("node", "article", "field_jf_task");
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_jf_task") : NULL;
  $type = $fs ? $fs->getType() : "none";
  $widget = $c["type"] ?? "none";
  $ok = ($type === "json_native") && $fc && ($widget === "json_textarea");
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " instance=" . ($fc ? "yes" : "no") . " widget=" . $widget . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
