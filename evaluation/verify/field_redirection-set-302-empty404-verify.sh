#!/usr/bin/env bash
# Execution VERIFY: PASS when field_fr_temp uses field_redirection_formatter with code 302 AND
# 404_if_empty TRUE. Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_fr_temp") : NULL;
  $type = $c["type"] ?? "none";
  $code = $c["settings"]["code"] ?? NULL;
  $e404 = $c["settings"]["404_if_empty"] ?? NULL;
  $ok = ($type === "field_redirection_formatter") && ((int) $code === 302) && ((bool) $e404 === TRUE);
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " code=" . var_export($code, TRUE) . " 404_if_empty=" . var_export($e404, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
