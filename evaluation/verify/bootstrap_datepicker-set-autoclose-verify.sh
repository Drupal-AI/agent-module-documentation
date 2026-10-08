#!/usr/bin/env bash
# Execution VERIFY: PASS when field_bsd_auto uses bootstrap_date_widget AND its settings.autoclose
# is truthy. Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_bsd_auto") : NULL;
  $type = $c["type"] ?? "none";
  $auto = $c["settings"]["autoclose"] ?? NULL;
  $ok = ($type === "bootstrap_date_widget") && !empty($auto);
  print ($ok ? "PASS" : "FAIL") . " widget=" . $type . " autoclose=" . var_export($auto, TRUE);
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
