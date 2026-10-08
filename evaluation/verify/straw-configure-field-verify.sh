#!/usr/bin/env bash
# Execution VERIFY: PASS when field_straw_task uses the straw handler AND the Straw widget.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("node","article","field_straw_task");
  $handler = $fc ? $fc->getSetting("handler") : "none";
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_straw_task") : NULL;
  $widget = $c["type"] ?? "none";
  $ok = ($handler === "straw") && ($widget === "super_term_reference_autocomplete_widget");
  print ($ok ? "PASS" : "FAIL") . " handler=$handler widget=$widget";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
