#!/usr/bin/env bash
# Execution VERIFY: PASS when the sais_dym default display has a header area handler whose
# plugin_id is search_api_spellcheck_did_you_mean. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("sais_dym");
  $ok = FALSE; $found = "none";
  if ($v) {
    $d = $v->getDisplay("default");
    foreach (($d["display_options"]["header"] ?? []) as $h) {
      if (($h["plugin_id"] ?? "") === "search_api_spellcheck_did_you_mean") { $ok = TRUE; $found = $h["plugin_id"]; }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " header_handler=" . $found . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
