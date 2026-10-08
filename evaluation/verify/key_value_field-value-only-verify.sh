#!/usr/bin/env bash
# Execution VERIFY: PASS when field_kvf_disp's key_value formatter on the default view display
# has value_only === TRUE (key hidden). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::service("entity_display.repository")->getViewDisplay("node", "article", "default");
  $c = $vd->getComponent("field_kvf_disp");
  $type = $c["type"] ?? "none";
  $vo = $c["settings"]["value_only"] ?? NULL;
  $ok = ($type === "key_value") && ($vo === TRUE);
  print ($ok ? "PASS" : "FAIL") . " formatter=" . $type . " value_only=" . var_export($vo, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
