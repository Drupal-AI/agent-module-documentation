#!/usr/bin/env bash
# Execution VERIFY: PASS when Article has a Date/time field field_dtn_task whose default
# form-display widget renders the core 'datetime' element (datetime_default), so the
# datetime_now Now button will appear on it; also asserts datetime_now's process callback is
# wired into the datetime element. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  use Drupal\field\Entity\FieldStorageConfig;
  $fc = FieldConfig::loadByName("node", "article", "field_dtn_task");
  $fs = FieldStorageConfig::loadByName("node", "field_dtn_task");
  $isdt = $fs && $fs->getType() === "datetime";
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_dtn_task") : NULL;
  $w = $c["type"] ?? "none";
  $widget_ok = ($w === "datetime_default");
  $info = \Drupal::service("plugin.manager.element_info")->getInfo("datetime");
  $wired = FALSE;
  foreach (($info["#process"] ?? []) as $p) {
    if (is_array($p) && is_object($p[0]) && strpos(get_class($p[0]), "datetime_now") !== FALSE) { $wired = TRUE; }
  }
  $ok = $fc && $isdt && $widget_ok && $wired;
  print ($ok ? "PASS" : "FAIL") . " field=" . ($fc ? "yes" : "no") . " type=" . ($fs ? $fs->getType() : "none") . " widget=" . $w . " now_wired=" . ($wired ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
