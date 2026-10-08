#!/usr/bin/env bash
# Execution VERIFY: PASS when field_erfl_pick uses the Facet link formatter AND its facet
# setting is 'erfl_hard_facet'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_erfl_pick") : NULL;
  $type = $c["type"] ?? "none";
  $facet = $c["settings"]["facet"] ?? NULL;
  $ok = ($type === "entity_reference_facet_link" && $facet === "erfl_hard_facet");
  print ($ok ? "PASS" : "FAIL") . " formatter=" . $type . " facet=" . var_export($facet, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
