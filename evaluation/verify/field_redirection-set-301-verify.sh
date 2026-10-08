#!/usr/bin/env bash
# Execution VERIFY: PASS when field_fr_link uses field_redirection_formatter with settings.code
# == 301. Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_fr_link") : NULL;
  $type = $c["type"] ?? "none";
  $code = $c["settings"]["code"] ?? NULL;
  $ok = ($type === "field_redirection_formatter") && ((int) $code === 301);
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " code=" . var_export($code, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
