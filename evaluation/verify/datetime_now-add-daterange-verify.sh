#!/usr/bin/env bash
# Execution VERIFY: PASS when Article has a Datetime Range field field_dtn_period whose
# default form-display widget is daterange_default (renders 'datetime' sub-elements, so the
# datetime_now Now button appears on both start and end); also asserts datetime_now is wired
# into the datetime element. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  use Drupal\field\Entity\FieldStorageConfig;
  $fc = FieldConfig::loadByName("node", "article", "field_dtn_period");
  $fs = FieldStorageConfig::loadByName("node", "field_dtn_period");
  $isrange = $fs && $fs->getType() === "daterange";
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_dtn_period") : NULL;
  $w = $c["type"] ?? "none";
  $widget_ok = ($w === "daterange_default");
  $info = \Drupal::service("plugin.manager.element_info")->getInfo("datetime");
  $wired = FALSE;
  foreach (($info["#process"] ?? []) as $p) {
    if (is_array($p) && is_object($p[0]) && strpos(get_class($p[0]), "datetime_now") !== FALSE) { $wired = TRUE; }
  }
  $ok = $fc && $isrange && $widget_ok && $wired;
  print ($ok ? "PASS" : "FAIL") . " field=" . ($fc ? "yes" : "no") . " type=" . ($fs ? $fs->getType() : "none") . " widget=" . $w . " now_wired=" . ($wired ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
