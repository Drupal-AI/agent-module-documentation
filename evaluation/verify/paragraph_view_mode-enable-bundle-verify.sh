#!/usr/bin/env bash
# Execution VERIFY for "enable Paragraph View Mode on the pvm_task paragraph type".
# PASS when BOTH hold:
#   * FieldConfig paragraph.pvm_task.paragraph_view_mode exists (field type paragraph_view_mode)
#   * core.entity_form_display.paragraph.pvm_task.default has a visible (region=content)
#     paragraph_view_mode component using the paragraph_view_mode widget.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("paragraph", "pvm_task", "paragraph_view_mode");
  $type = $fc ? $fc->getType() : "none";
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("paragraph.pvm_task.default");
  $c = $fd ? $fd->getComponent("paragraph_view_mode") : NULL;
  $widget = $c["type"] ?? "none";
  $region = $c["region"] ?? "none";
  $ok = ($fc !== NULL) && ($type === "paragraph_view_mode")
        && ($widget === "paragraph_view_mode") && ($region === "content");
  print ($ok ? "PASS" : "FAIL") . " field=" . ($fc ? "yes" : "no") . " field_type=" . $type
        . " widget=" . $widget . " region=" . $region . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
