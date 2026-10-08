#!/usr/bin/env bash
# Execution VERIFY: PASS when field_tjm_task's component in the default view display uses formatter
# type tacjs_oembed. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_tjm_task") : NULL;
  $t = $c["type"] ?? "none";
  print (($t === "tacjs_oembed") ? "PASS" : "FAIL") . " type=" . $t . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
