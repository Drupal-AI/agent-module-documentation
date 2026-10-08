#!/usr/bin/env bash
# Execution VERIFY for "create a Range (integer) field field_range_task on Article".
# PASS when:
#   - field storage node.field_range_task exists and its type is range_integer
#   - the Article instance exists with range field settings min=1 and max=100
#   - the default form display renders it with the module's 'range' widget
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $fs = FieldStorageConfig::loadByName("node", "field_range_task");
  $fc = FieldConfig::loadByName("node", "article", "field_range_task");
  $type = $fs ? $fs->getType() : "none";
  $min = $fc ? ($fc->getSetting("min")) : NULL;
  $max = $fc ? ($fc->getSetting("max")) : NULL;
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $widget = ($fd && ($c = $fd->getComponent("field_range_task"))) ? ($c["type"] ?? "none") : "none";
  $ok = $fs && $fc && $type === "range_integer" && (int) $min === 1 && (int) $max === 100 && $widget === "range";
  print ($ok ? "PASS" : "FAIL")
    . " type=" . $type
    . " min=" . var_export($min, TRUE)
    . " max=" . var_export($max, TRUE)
    . " widget=" . $widget . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
