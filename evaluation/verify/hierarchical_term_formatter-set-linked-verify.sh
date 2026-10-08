#!/usr/bin/env bash
# VERIFY: PASS when field_htf_path uses hierarchical_term_formatter with display=all, link=true, separator=" > ".
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::service("entity_display.repository")->getViewDisplay("node", "article", "default");
  $c = $vd->getComponent("field_htf_path");
  $type = $c["type"] ?? "none";
  $disp = $c["settings"]["display"] ?? "none";
  $link = $c["settings"]["link"] ?? NULL;
  $sep  = $c["settings"]["separator"] ?? "";
  $ok = ($type === "hierarchical_term_formatter" && $disp === "all" && $link == TRUE && $sep === " > ");
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " display=" . $disp . " link=" . var_export($link, TRUE) . " sep=[" . $sep . "]\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
