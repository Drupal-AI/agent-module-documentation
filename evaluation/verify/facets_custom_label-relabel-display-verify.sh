#!/usr/bin/env bash
# VERIFY: PASS when facet fcl_relabel has facets_custom_label enabled with replacement_values containing "d|Article|News".
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $f = \Drupal\facets\Entity\Facet::load("fcl_relabel");
  $rv = "";
  $has = FALSE;
  if ($f) {
    $pc = $f->getProcessorConfigs();
    if (isset($pc["facets_custom_label"])) {
      $has = TRUE;
      $rv = $pc["facets_custom_label"]["settings"]["replacement_values"] ?? "";
    }
  }
  $ok = $has && (strpos($rv, "d|Article|News") !== FALSE);
  print ($ok ? "PASS" : "FAIL") . " processor=" . ($has ? "yes" : "no") . " rv=[" . str_replace("\n", "\\n", $rv) . "]\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
