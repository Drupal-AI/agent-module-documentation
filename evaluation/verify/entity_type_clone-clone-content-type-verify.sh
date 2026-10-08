#!/usr/bin/env bash
# Execution VERIFY: PASS when the content type etc_task_dst exists, carries the field
# field_etc_task, and that field is present as a component on both its default form display
# and its default view display (i.e. a real Entity Type Clone result, not just a bare type).
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldConfig;
  $type = (bool) NodeType::load("etc_task_dst");
  $field = (bool) FieldConfig::loadByName("node", "etc_task_dst", "field_etc_task");
  $repo = \Drupal::service("entity_display.repository");
  $fd = $repo->getFormDisplay("node", "etc_task_dst", "default");
  $vd = $repo->getViewDisplay("node", "etc_task_dst", "default");
  $inForm = $fd && $fd->getComponent("field_etc_task") !== NULL;
  $inView = $vd && $vd->getComponent("field_etc_task") !== NULL;
  $ok = $type && $field && $inForm && $inView;
  print ($ok ? "PASS" : "FAIL")
    . " type=" . var_export($type, TRUE)
    . " field=" . var_export($field, TRUE)
    . " form_display=" . var_export($inForm, TRUE)
    . " view_display=" . var_export($inView, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
