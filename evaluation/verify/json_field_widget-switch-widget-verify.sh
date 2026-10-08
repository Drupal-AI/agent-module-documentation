#!/usr/bin/env bash
# Execution VERIFY: PASS when field_jfw_task's component on
# core.entity_form_display.node.article.default uses the json_editor widget with mode=code
# and offers the "tree" mode in its modes list. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_jfw_task") : NULL;
  $type = $c["type"] ?? "none";
  $mode = $c["settings"]["mode"] ?? "none";
  $modes = array_values(array_filter((array) ($c["settings"]["modes"] ?? [])));
  $ok = ($type === "json_editor") && ($mode === "code") && in_array("tree", $modes, TRUE);
  print ($ok ? "PASS" : "FAIL") . " widget=" . $type . " mode=" . $mode . " modes=" . implode("|", $modes) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
