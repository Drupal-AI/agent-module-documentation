#!/usr/bin/env bash
# VERIFY: PASS when field_htf_cats uses hierarchical_term_formatter with settings.display=root.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::service("entity_display.repository")->getViewDisplay("node", "article", "default");
  $c = $vd->getComponent("field_htf_cats");
  $type = $c["type"] ?? "none";
  $disp = $c["settings"]["display"] ?? "none";
  $ok = ($type === "hierarchical_term_formatter" && $disp === "root");
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " display=" . $disp . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
